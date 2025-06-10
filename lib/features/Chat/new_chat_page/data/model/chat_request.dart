
import 'chat_image.dart';

class ChatRequest{
  String? prompt;
  int? chatID;
  String? label;//the detected monument
  ChatImage? image;

  ChatRequest({this.prompt, this.chatID, this.label, this.image});

  Map<String, dynamic> toJson() {
    return {
      "prompt": prompt,
      "chat_id": chatID,
      "classes": label,
      "image":image?.toBase64()
    };
  }
  ChatRequest copyWith({
    String? prompt,
    int? chatID,
    String? label,
    ChatImage? image,
  }) {
    return ChatRequest(
      prompt: prompt ?? this.prompt,
      chatID: chatID ?? this.chatID,
      label: label ?? this.label,
      image: image ?? this.image,
    );
  }
}