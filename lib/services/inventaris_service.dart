import 'dart:convert';
import 'dart:io';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class InventarisService {
  final String baseUrl = "${ApiNetwork.BASE_URL}/inventory";

  Future<List<CategoryModel>> getCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("$baseUrl/category"),
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

  Future<List<LocationModel>> getLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("$baseUrl/location"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return (json['data'] as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengambil data lokasi',
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

  Future<List<InventoryModel>> getInventories() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse("${baseUrl}/item"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return (json['data'] as List)
            .map((e) => InventoryModel.fromJson(e))
            .toList();
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengambil data inventory',
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

  Future<void> createInventory({
    required String name,
    required String description,
    required String categoryId,
    required String locationId,
    required String initialStock,
    required File image,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${baseUrl}/item"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true",
      });

      request.fields["name"] = name;
      request.fields["description"] = description;
      request.fields["categoryId"] = categoryId;
      request.fields["locationId"] = locationId;
      request.fields["initialStock"] = initialStock;

      final mimeType = lookupMimeType(image.path)?.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          "image",
          image.path,
          contentType: MediaType(mimeType![0], mimeType[1]),
        ),
      );

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      final json = jsonDecode(response.body);

      if (response.statusCode == 201 && json['status'] == 'success') {
        return;
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal menambahkan inventory',
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

  Future<void> updateItem({
    required String itemId,
    String? name,
    String? description,
    String? categoryId,
    String? locationId,
    File? image,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final request = http.MultipartRequest(
        "PATCH",
        Uri.parse("$baseUrl/item/$itemId"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true",
      });

      // Hanya kirim field yang tidak null
      if (name != null) request.fields["name"] = name;
      if (description != null) request.fields["description"] = description;
      if (categoryId != null) request.fields["categoryId"] = categoryId;
      if (locationId != null) request.fields["locationId"] = locationId;

      if (image != null) {
        final mimeType = lookupMimeType(image.path)?.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            "image",
            image.path,
            contentType: MediaType(mimeType![0], mimeType[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return;
      }

      throw AppError(
        status: json['status'] ?? 'error',
        statusCode: response.statusCode,
        message: json['message'] ?? 'Gagal mengupdate item',
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
