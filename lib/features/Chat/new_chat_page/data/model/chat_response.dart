class ChatResponse {
  String? status;
  Null error;
  int? chatId;
  String? chatTitle;
  String? response;

  ChatResponse({this.status, this.error,this.response,this.chatId,this.chatTitle});

  ChatResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    chatId =  json['data']['chat_id'];
    chatTitle =  json['data']['chat_title'];
    response =  json['data']['response'];
  }
}
