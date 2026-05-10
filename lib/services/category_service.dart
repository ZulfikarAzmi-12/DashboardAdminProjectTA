import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String baseUrl = "${ApiNetwork.BASE_URL}/inventory/category";
  Future<List<CategoryModel>> getCategorys() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return (json['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengambil data category',
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

  Future<CategoryModel> createCategory(String categoryName) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"categoryName": categoryName}),
      );

      final json = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          json['status'] == 'success') {
        return CategoryModel.fromJson(json['data']);
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal menambahkan category',
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

  Future<CategoryModel> updateCategory({
    required String categoryId,
    required String categoryName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$baseUrl/$categoryId"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"categoryName": categoryName}),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return CategoryModel.fromJson(json['data']);
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal update category',
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
