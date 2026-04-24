import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void login() async {
    try {
      String username = usernameController.text.toString();
      String password = passwordController.text.toString();

      final result = await _authService.login(username, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accesToken", result.data.accesToken);

      Get.snackbar(
        "Success",
        result.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed(AppRoutes.main);
    } on AppError catch (e) {
      String message = e.message;
      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"]; // ambil error pertama
      }
      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    // Bersihkan memori saat controller tidak dipakai
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
