import 'dart:convert';

import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailInventoryService {
  final String BASE_URL = "${ApiNetwork.BASE_URL}/inventory/item";

  Future<ItemDetailModel> getItemDetail(String itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("$BASE_URL/$itemId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && body['status'] == 'success') {
        return ItemDetailModel.fromJson(body['data'] as Map<String, dynamic>);
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
      print("error item detail: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }

  Future<String> toggleItemAvailability(
    String itemId,
    bool currentStatus,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$BASE_URL/availability/$itemId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "isAvalible": !currentStatus, // toggle: true → false, false → true
        }),
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
      print("error toggle availability: $e");
      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan pada server",
        error: e,
      );
    }
  }
}
