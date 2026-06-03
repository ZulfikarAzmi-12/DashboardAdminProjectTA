import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoanService {
  final String baseUrl = ApiNetwork.BASE_URL;

  Future<List<LoanData>> getLoans() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse("$baseUrl/loan"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200 && json['status'] == 'success') {
        return (json['data'] as List).map((e) => LoanData.fromJson(e)).toList();
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
        status: 'error',
        statusCode: 500,
        message: 'Terjadi Kesalahan',
        error: e,
      );
    }
  }

  Future<List<ScheduleModel>> getUnitSchedule(String unitId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("$baseUrl/inventory/unit/schedule/$unitId"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return (json['data'] as List)
            .map((e) => ScheduleModel.fromJson(e))
            .toList();
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengambil jadwal unit',
      );
    } catch (e) {
      if (e is AppError) rethrow;
      throw AppError(
        status: 'error',
        statusCode: 500,
        message: 'Terjadi kesalahan saat mengambil jadwal',
        error: e,
      );
    }
  }

  Future<void> borrowUnit({
    required String unitId,
    required String userId, // ← tambah ini
    required String purpose,
    required String borrowedDate,
    required String returnDate,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.post(
        Uri.parse("$baseUrl/loan"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "unitId": unitId,
          "userId": userId, // ← tambah ini
          "purpose": purpose,
          "borrowedDate": borrowedDate,
          "returnDate": returnDate,
        }),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 201 && json['status'] == 'success') return;

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal meminjam unit',
      );
    } catch (e) {
      if (e is AppError) rethrow;
      throw AppError(
        status: 'error',
        statusCode: 500,
        message: 'Terjadi kesalahan saat meminjam',
        error: e,
      );
    }
  }
}
