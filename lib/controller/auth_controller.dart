import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Buat controller untuk menampung input teks
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    String email = emailController.text;
    String pass = passwordController.text;
    
    if (email.isNotEmpty && pass.isNotEmpty) {
      print("Proses Login dengan: $email");
      // Tambahkan logika koneksi ke API Laravel kamu di sini
    } else {
      Get.snackbar("Error", "Email dan Password harus diisi",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  
  @override
  void onClose() {
    // Bersihkan memori saat controller tidak dipakai
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}