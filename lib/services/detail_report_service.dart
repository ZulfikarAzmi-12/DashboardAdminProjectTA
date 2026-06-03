import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailReportService {
  final String baseUrl = "${ApiNetwork.BASE_URL}/damage-report";
  Future<String> updateReportStatus({
    required String reportId,
    required String currentStatus,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final nextStatus = currentStatus.toLowerCase() == 'pending'
          ? 'diproses'
          : 'selesai';

      final response = await http.patch(
        Uri.parse("$baseUrl/$reportId"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"status": nextStatus}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return json['message'];
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal update status laporan',
        errors: json['errors'],
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
