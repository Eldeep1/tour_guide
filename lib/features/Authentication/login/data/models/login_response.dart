class LoginResponse{
  String accessToken;
  String refreshToken;

LoginResponse({
    required this.accessToken,
  required this.refreshToken,
});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }
}