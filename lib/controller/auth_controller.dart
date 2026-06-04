import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/auth_service.dart';
import 'package:admin_dashboard/services/notif_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final NotifService _notifService = NotifService();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    // Ambil input
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validasi email kosong
    if (username.isEmpty) {
      Get.snackbar(
        "Error",
        "Harap isi username anda",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

   
    // Validasi password kosong
    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "Harap isi password anda",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Hindari spam klik
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final result = await _authService.login(
        username,
        password,
      );

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        "accesToken",
        result.data.accesToken,
      );

      await prefs.setString(
        "role",
        result.data.role,
      );

      try {
        await _notifService.initFCMToken(
          result.data.accesToken,
        );
      } catch (e) {
        debugPrint("FCM gagal dikirim: $e");
      }

      if (result.data.role != 'admin') {
        Get.snackbar(
          "Error",
          "Kamu bukan admin",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Get.snackbar(
        "Success",
        result.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offNamed(AppRoutes.main);
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint("Login Error: $e");

      Get.snackbar(
        "Error",
        "Terjadi kesalahan pada server",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}