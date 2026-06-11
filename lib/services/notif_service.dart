import 'dart:convert';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/notif_model.dart';
import 'package:admin_dashboard/networks/api.network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotifService {
  final String BASE_URL = "${ApiNetwork.BASE_URL}/notification";

  Future<List<NotifModel>> getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("accessToken");

      final response = await http.get(
        Uri.parse(BASE_URL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        final List data = json['data'] as List;
        return data.map((e) => NotifModel.fromJson(e)).toList();
      }

      throw AppError(
        status: json['status'] ?? 'failed',
        statusCode: json['statusCode'],
        message: json['message'],
        error: json['error'],
        errors: json['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;

      print("error getNotifications: $e");

      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan saat mengambil data notifikasi",
        error: e,
      );
    }
  }

  Future<void> initFCMToken(String jwtToken) async {
    try {
      final String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken == null) {
        print("FCM Token null");
        return;
      }

      final response = await http.post(
        Uri.parse(BASE_URL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode({"token": fcmToken}),
      );

      print("FCM Token berhasil dikirim");
      print(response.body);
    } catch (e) {
      print("Error init FCM token: $e");
    }
  }

  Future<void> readNotification(String notifId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("accessToken");

      final response = await http.patch(
        Uri.parse("$BASE_URL/$notifId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['status'] == 'success') {
        return;
      }

      throw AppError(
        status: json['status'] ?? 'failed',
        statusCode: json['statusCode'],
        message: json['message'],
        error: json['error'],
        errors: json['errors'],
      );
    } catch (e) {
      if (e is AppError) rethrow;

      print("error readNotification: $e");

      throw AppError(
        status: "error",
        statusCode: 500,
        message: "Terjadi kesalahan saat mengubah status notifikasi",
        error: e,
      );
    }
  }
}
