import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/home_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final String baseUrl = ApiNetwork.BASE_URL;

  Future<SummaryModel> getSummary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse("$baseUrl/inventory/summary"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 401 && json['status'] != 'success') {
        Get.offAllNamed(AppRoutes.login);
      }

      if (response.statusCode == 200 && json['status'] == 'success') {
        return SummaryModel.fromJson(json['data']);
      }
      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengambil summary',
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
