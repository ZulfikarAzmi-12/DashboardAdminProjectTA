import 'package:admin_dashboard/firebase_options.dart';
import 'package:admin_dashboard/routes/app_pages.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/notif_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await _requestPermissions();
  final NotifService notifService = NotifService();

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString("accessToken");

  if (token != null && token.isNotEmpty) {
    await notifService.initFCMToken(token);
  }

  String initialRoute = AppRoutes.splash;

  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();

  if (initialMessage != null) {
    initialRoute = AppRoutes.notification;
  }

  runApp(MyApp(initialRoute: initialRoute));
  _setupFCMListener();
}

Future<void> _requestPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User mengizinkan notification");
  } else {
    print("User tidak mengizinkan notification");
  }
}

void _setupFCMListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;

    print("ADA PESAN MASUK");
    print(message.data);
    print(message.notification?.title);

    if (notification != null) {
      Get.snackbar(
        notification.title ?? "Notifikasi",
        notification.body ?? "Ada pesan baru",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFF42A5F5),
        colorText: Colors.white,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Get.toNamed(AppRoutes.notification);
  });
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    );
  }
}
