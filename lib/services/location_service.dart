import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final String baseUrl = "${ApiNetwork.BASE_URL}/inventory/location";

  Future<LocationModel> createLocation(String locationName) async {
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
        body: jsonEncode({"locationName": locationName}),
      );

      final json = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          json['status'] == 'success') {
        return LocationModel.fromJson(json['data']);
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal menambahkan lokasi',
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

  Future<LocationModel> updateLocation({
    required String locationId,
    String? locationName,
    bool? isActive,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      Map<String, dynamic> body = {};

      if (locationName != null) {
        body["locationName"] = locationName;
      }

      if (isActive != null) {
        body["isActive"] = isActive;
      }

      final response = await http.patch(
        Uri.parse("$baseUrl/$locationId"),

        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },

        body: jsonEncode(body),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return LocationModel.fromJson(json['data']);
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal update lokasi',
        errors: json['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;
      print("error mas  $e");
      throw AppError(
        status: 'error',
        statusCode: 500,
        message: 'Terjadi kesalahan',
        error: e,
      );
    }
  }
}
