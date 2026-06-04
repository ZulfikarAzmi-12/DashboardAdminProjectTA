import 'package:admin_dashboard/components/button/login_button.dart';
import 'package:admin_dashboard/components/textfield/login_textfield.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),

              const SizedBox(height: 60),

              LoginTextField(
                hintText: 'example@gmail.com',
                prefixIcon: Icons.person,
                controller: authController.usernameController,
              ),

              Obx(
                () => LoginTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: authController.passwordController,
                  obscureText: authController.obscurePassword.value,
                  onSuffixIconPressed: authController.togglePasswordVisibility,
                ),
              ),

              const SizedBox(height: 40),

              Obx(
                () => LoginButton(
                  backgroundColor: AppColor.primary,
                  text: 'Login',
                  isLoading: authController.isLoading.value,
                  onPressed: authController.isLoading.value
                      ? null
                      : authController.login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
