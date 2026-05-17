import 'dart:convert';

import 'package:admin_dashboard/models/detail_loan_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanDetailService {
  final String BASE_URL = "${ApiNetwork.BASE_URL}/loan";

  // ── GET detail ────────────────────────────────────────────────────────────
  Future<LoanDetailModel> getLoanDetail(String loanId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("$BASE_URL/$loanId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && body['status'] == 'success') {
        return LoanDetailModel.fromJson(body['data'] as Map<String, dynamic>);
      }

      throw AppError(
        status: body['status'] ?? 'failed',
        statusCode: body['statusCode'],
        message: body['message'],
        error: body['error'],
        errors: body['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      print("error loan detail: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }

  // ── PATCH accept/:loanId ──────────────────────────────────────────────────
  Future<String> acceptLoan(String loanId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$BASE_URL/accept/$loanId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && body['status'] == 'success') {
        return body['message'] as String;
      }

      throw AppError(
        status: body['status'] ?? 'failed',
        statusCode: body['statusCode'],
        message: body['message'],
        error: body['error'],
        errors: body['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      print("error accept loan: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }

  // ── PATCH reject/:loanId ──────────────────────────────────────────────────
  Future<String> rejectLoan(String loanId, String reason) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$BASE_URL/reject/$loanId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"reason": reason}),
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && body['status'] == 'success') {
        return body['message'] as String;
      }

      throw AppError(
        status: body['status'] ?? 'failed',
        statusCode: body['statusCode'],
        message: body['message'],
        error: body['error'],
        errors: body['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      print("error reject loan: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }

  // ── PATCH return/:loanId ──────────────────────────────────────────────────
  Future<String> returnLoan(String loanId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$BASE_URL/return/$loanId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && body['status'] == 'success') {
        return body['message'] as String;
      }

      throw AppError(
        status: body['status'] ?? 'failed',
        statusCode: body['statusCode'],
        message: body['message'],
        error: body['error'],
        errors: body['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      print("error return loan: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }
}
