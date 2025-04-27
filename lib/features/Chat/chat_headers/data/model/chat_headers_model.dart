class ChatHeaders {
  String? status;
  List<HeadersData>? data;

  ChatHeaders({this.status, this.data});

  ChatHeaders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HeadersData>[];
      json['data'].forEach((v) {
        data!.add(HeadersData.fromJson(v));
      });
    }
  }

}

class HeadersData {
  int? id;
  String? title;
  String? createdAt;

  HeadersData({this.id, this.title, this.createdAt});

  HeadersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['created_at'] = createdAt;
    return data;
  }
}