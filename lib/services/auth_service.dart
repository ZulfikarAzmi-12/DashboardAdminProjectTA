import 'dart:convert';

import 'package:admin_dashboard/models/auth_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseURL = "${ApiNetwork.BASE_URL}/auth";

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/login"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"username": username, "password": password}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        final token = json['data']['accesToken'];
        print("token $token");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token);
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
      print("error rek: ${e}");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan",
        error: e,
      );
    }
  }

  Future<void> changePassword({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.post(
        Uri.parse("$baseURL/reset"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "passwordLama": passwordLama,
          "passwordBaru": passwordBaru,
        }),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return;
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengganti password',
      );
    } catch (e) {
      if (e is AppError) rethrow;

      throw AppError(
        status: 'error',
        statusCode: 500,
        message: 'Terjadi kesalahan',
        error: e,
      );
    }
  }
}
