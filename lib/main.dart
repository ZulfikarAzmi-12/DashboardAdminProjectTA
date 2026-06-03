import 'package:admin_dashboard/firebase_options.dart';
import 'package:admin_dashboard/routes/app_pages.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await _requestPermissions();

  runApp(const MyApp());

  _setupFCMListener();
}

Future<void> _requestPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("user mengizinkan permissions");
  } else {
    print("user tidak mengizinkan permissions");
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
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Get.toNamed(AppRoutes.main);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}