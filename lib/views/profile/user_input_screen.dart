import 'package:amommy/models/user_model.dart';
import 'package:amommy/views/common/bottom_button.dart';
import 'package:amommy/views/profile/hobby_input_view.dart';
import 'package:amommy/views/profile/hobby_value.dart';
import 'package:amommy/views/profile/select_input_view.dart';
import 'package:amommy/views/profile/text_input_view.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInputScreen extends ConsumerStatefulWidget {
  const UserInputScreen({super.key});

  @override
  ConsumerState<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends ConsumerState<UserInputScreen>
    with UserState {
  late final PageController pageController;
  List<Widget> get pages => [
        TextInputView(
          user(ref)?.name ?? "",
          "What's your name?",
          "Enter your name",
          ref.watch(userProvider.notifier).onNameChanged,
        ),
        TextInputView(
          user(ref)?.age?.toString() ?? "",
          "What's your age?",
          "Enter your age",
          ref.watch(userProvider.notifier).onAgeChanged,
          isNumber: true,
        ),
        SelectInputView(
          Language.values.map((e) => e.name).toList(),
          "What's your language?",
          user(ref)?.language?.name,
          ref.watch(userProvider.notifier).onLanguageChanged,
        ),
        TextInputView(
          user(ref)?.livingArea?.toString() ?? "",
          "Where are you living?",
          "Enter your city name",
          ref.watch(userProvider.notifier).onLivingAreaChanged,
        ),
        HobbyInputScreen(
          user(ref)?.hobbies ?? [],
          "What is your hobby?",
          "Enter your hobby",
        ),
        TextInputView(
          user(ref)?.job?.toString() ?? "",
          "Where are do for your work?",
          "Enter your job",
          ref.watch(userProvider.notifier).onLivingAreaChanged,
        ),
      ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int get currentIndex => pageController.page!.toInt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomButton(
          text: "다음",
          onPressed: () async {
            final userNotifier = ref.read(userProvider.notifier);
            if (currentIndex == 4) {
              final List<String> hobbies = ref.read(hobbyValueProvider);
              await userNotifier.saveHobbies(hobbies);
            } else {
              await userNotifier.saveCurrentState();
            }
            if (currentIndex < pages.length - 1) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.only(top: 160),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) => FocusScope.of(context).unfocus(),
                  children: pages,
                ),
              ),
            ),
            SizedBox(height: BottomButton.height),
          ],
        ),
      ),
    );
  }
}
