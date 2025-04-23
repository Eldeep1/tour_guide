class LoginResponse{
  String accessToken;
  String refreshToken;

LoginResponse({
    required this.accessToken,
  required this.refreshToken,
});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; // fallback if data is already the inner map
    return LoginResponse(
      accessToken: data['access'],
      refreshToken: data['refresh'],
    );
  }
}