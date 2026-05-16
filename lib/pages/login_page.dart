import 'package:admin_dashboard/components/button/long_button.dart';
import 'package:admin_dashboard/components/textfield/login_textfield.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Judul Login
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),

              const SizedBox(height: 60),

              // Input Email
              LoginTextField(
                hintText: 'example@gmail.com',
                prefixIcon: Icons.email_outlined,
                controller: authController.usernameController,
              ),

              // Input Password
              LoginTextField(
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: authController.passwordController,
              ),

              const SizedBox(height: 40),

              // Tombol Login
              LongButton(
                backgroundColor: AppColor.primary,
                text: 'Login',
                onPressed: () {
                  authController.login();
                },
              ),

              // Bagian "Belum punya akun" sudah dihapus dari sini
            ],
          ),
        ),
      ),
    );
  }
}
