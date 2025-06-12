import 'dart:typed_data';

class ChatHistory {
  String? status;
  Null error;
  List<Data>? data;

  ChatHistory({this.status, this.error, this.data});

  ChatHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? prompt;
  String? response;
  int? chatId;
  Uint8List? byteImage;
  String? linkImage;
  Data({this.id, this.prompt, this.response, this.chatId,this.byteImage,this.linkImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prompt = json['prompt'];
    response = json['response'];
    chatId = json['chat_id'];
    linkImage=json['image'];
  }
}
