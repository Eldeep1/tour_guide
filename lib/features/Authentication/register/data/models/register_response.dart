class RegisterResponse {
  String? status;
  Error? error;
  Data? data;

  RegisterResponse({this.status, this.error, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Error {
  List<String>? email;
  List<String>? password;

  Error({this.email, this.password});

  Error.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;

  Data({this.id, this.name, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
