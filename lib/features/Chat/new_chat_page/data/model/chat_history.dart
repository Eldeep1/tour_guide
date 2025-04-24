class ChatHistory {
  String? status;
  Null? error;
  List<Data>? data;

  ChatHistory({this.status, this.error, this.data});

  ChatHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? prompt;
  String? response;
  int? chatId;

  Data({this.id, this.prompt, this.response, this.chatId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prompt = json['prompt'];
    response = json['response'];
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prompt'] = this.prompt;
    data['response'] = this.response;
    data['chat_id'] = this.chatId;
    return data;
  }
}
