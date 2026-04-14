import 'dart:convert';

import 'package:admin_dashboard/models/auth_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseURL = "https://af3b-182-8-229-28.ngrok-free.app/api/v1/auth";

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return LoginResponse.fromJson(json);
      }

      throw AppError(
        status: json['status'] ?? 'failed',
        statusCode: json['statusCode'],
        message: json['message'],
        error: json['error'],
        errors: json["errors"],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan",
        error: e,
      );
    }
  }
}
