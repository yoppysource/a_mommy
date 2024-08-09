// Routine can be two way of it. First daily routine and one time routine.
import 'dart:io';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';
part 'chat_message_model.g.dart';

@HiveType(typeId: 3)
class ChatMessageModel extends HiveObject {
  static const String boxName = 'chat_message';

  @HiveField(0)
  DateTime created;
  @HiveField(1)
  String? message;
  @HiveField(2)
  String? imagePath;
  @HiveField(3)
  bool isMe;

  ChatMessageModel({
    required this.created,
    this.message,
    this.imagePath,
    required this.isMe,
  });

  Future<Content> toContent() async {
    return Content(isMe ? "user" : "model", [
      imagePath != null
          ? await _imageToDataPart(imagePath!)
          : TextPart(message!)
    ]);
  }

  Future<DataPart> _imageToDataPart(String imagePath) async {
    // Read the image file as bytes
    final File imageFile = File(imagePath);
    final Uint8List imageBytes = await imageFile.readAsBytes();

    // Determine the MIME type (you can enhance this to support more types)
    String mimeType;
    if (imagePath.toLowerCase().endsWith('.jpg') ||
        imagePath.toLowerCase().endsWith('.jpeg')) {
      mimeType = 'image/jpeg';
    } else if (imagePath.toLowerCase().endsWith('.png')) {
      mimeType = 'image/png';
    } else {
      throw UnsupportedError('Unsupported file type');
    }

    // Create and return the DataPart instance
    return DataPart(mimeType, imageBytes);
  }
}
