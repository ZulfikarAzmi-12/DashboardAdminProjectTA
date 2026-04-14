class LoginResponse {
  final String status;
  final int statusCode;
  final String message;
  final LoginData data;

  LoginResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: LoginData.fromJson(json["data"]),
    );
  }
}

class LoginData {
  final String accesToken;
  final String role;

  LoginData({required this.accesToken, required this.role});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(accesToken: json["accesToken"], role: json["role"]);
  }
}
