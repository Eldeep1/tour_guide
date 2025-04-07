class TmpMessage {
  String? query;
  String? sessionId;
  String? userId;

  TmpMessage({this.query, this.sessionId, this.userId});

  TmpMessage.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    sessionId = json['session_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['session_id'] = this.sessionId;
    data['user_id'] = this.userId;
    return data;
  }
}