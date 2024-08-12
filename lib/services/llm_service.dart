import 'package:amommy/models/chat_message_model.dart';
import 'package:amommy/models/user_model.dart';
import 'package:amommy/services/alarm_service.dart';
import 'package:amommy/services/schedule_check_service.dart';
import 'package:amommy/utils.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'llm_service.g.dart';

class LLMService {
  LLMService(
    this.me,
    this._alarmService,
    this._scheduleCheckService,
  ) {
    String apiKey = dotenv.env['API_KEY']!;
    model = GenerativeModel(
      model: "gemini-1.5-pro-latest",
      apiKey: apiKey,
      tools: [
        Tool(functionDeclarations: [
          _alarmService.setMorningAlarmTool,
          _scheduleCheckService.setPlanTool
        ])
      ],
      safetySettings: [
        SafetySetting(
          HarmCategory.dangerousContent,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.harassment,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.hateSpeech,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.sexuallyExplicit,
          HarmBlockThreshold.none,
        ),
      ],
      generationConfig: GenerationConfig(
          // temperature/: 0.9,
          // topP: 1,
          ),
      // responseMimeType: "application/json",
    );
  }

  late final GenerativeModel model;
  final UserModel me;
  final AlarmService _alarmService;
  final ScheduleCheckService _scheduleCheckService;

  String get role =>
      "You are a concerned, nagging mom chatting with you son with mobile phone.";
  String get profileOfMe =>
      "Here is my profile: I am ${me.age} years old and your son. My name is ${me.name}. I am a ${me.job} living in ${me.livingArea}.I have the following hobbies: ${me.hobbies}.";

  String get circumstances =>
      "Now time is ${TimeOfDay.now().formattedString} and you are living faraway from son.";

  Future<String?> getMessage(
    List<ChatMessageModel> lastChats,
    String message,
  ) async {
    List<Content> contents =
        (await Future.wait(lastChats.map((e) => e.toContent())));

    if (contents.length > 10) {
      for (int i = 9; i < contents.length; i++) {
        if (contents[i].parts.first is DataPart) {
          contents.removeAt(i);
        }
      }
    }

    final chat = model.startChat(
      history: [
        Content('user', [TextPart(role + profileOfMe + circumstances)]),
        ...contents.reversed,
      ],
    );
    for (final history in chat.history) {
      for (final part in history.parts) {
        print(part.toJson());
      }
    }

    final GenerateContentResponse response =
        await chat.sendMessage(Content.text(message));
    try {
      final functionCalls = response.functionCalls.toList();
      for (final functionCall in functionCalls) {
        print(functionCall.toJson());
      }
// When the model response with a function call, invoke the function.
      if (functionCalls.isNotEmpty) {
        final functionCall = functionCalls.first;
        final result = switch (functionCall.name) {
          'setMorningAlarm' => await _alarmService.setAlarmFromLLM(
              functionCall.args,
            ),
          'notifyPlan' => await _scheduleCheckService.setPlanFromLLM(
              functionCall.args,
            ),
          _ => throw UnimplementedError(
              'Function not implemented: ${functionCall.name}',
            )
        };
        // Send the response to the model so that it can use the result to generate
        // text for the user.
        var response = await chat
            .sendMessage(Content.functionResponse(functionCall.name, result));
        if (response.text case final text) {
          return text;
        }
      } else if (response.text case final text?) {
        return text;
      }
    } catch (e) {
      return "Oops!! I forgot to turn off the gas stove. Let be back in a minute.";
    }
    return null;
  }
}

@Riverpod(keepAlive: true)
LLMService llmService(LlmServiceRef ref) {
  UserModel? user = ref.watch(userProvider);
  return LLMService(
    user!,
    ref.read(alarmServiceProvider).requireValue,
    ref.read(scheduleCheckServiceProvider),
  );
}
