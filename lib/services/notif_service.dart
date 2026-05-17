import 'dart:convert';

import 'package:admin_dashboard/networks/api.network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotifService {
  final String BASE_URL = "${ApiNetwork.BASE_URL}/notification";
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
}
