class RegisterRequest{
  String name;
  String email;
  String password;

  RegisterRequest(this.name, this.email, this.password);

  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "email":email,
      "password":password,
    };
  }
}