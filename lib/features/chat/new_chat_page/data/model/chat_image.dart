import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class ChatImage {
  final Uint8List bytes;
  final String? fileName;

  ChatImage({
    required this.bytes,
    this.fileName,
  });

  // Convert to base64 for JSON serialization
  String toBase64() => base64Encode(bytes);

  // Create from base64
  factory ChatImage.fromBase64(String base64String, {String? fileName, String? mimeType}) {
    return ChatImage(
      bytes: base64Decode(base64String),
      fileName: fileName,
    );
  }

  // Create from file
  static Future<ChatImage> fromFile(File file) async {
    final bytes = await file.readAsBytes();
    final fileName = file.path.split('/').last;

    return ChatImage(
      bytes: bytes,
      fileName: fileName,
    );
  }
}
