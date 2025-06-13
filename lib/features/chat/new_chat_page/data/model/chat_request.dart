
import 'chat_image.dart';

class ChatRequest{
  String? prompt;
  int? chatID;
  List<String>? label;
  ChatImage? image;
  double? longitude;
  double? latitude;

  ChatRequest({this.prompt, this.chatID, this.label, this.image,this.longitude,this.latitude});

  Map<String, dynamic> toJson() {
    return {
      "prompt": prompt,
      "chat_id": chatID,
      "classes": label,
      "image":image?.toBase64(),
      "longitude":longitude,
      "latitude ":latitude,
    };
  }
  ChatRequest copyWith({
    String? prompt,
    int? chatID,
    List<String>? label,
    ChatImage? image,
    double? longitude,
    double? latitude,
  }) {
    return ChatRequest(
      prompt: prompt ?? this.prompt,
      chatID: chatID ?? this.chatID,
      label: label ?? this.label,
      image: image ?? this.image,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}