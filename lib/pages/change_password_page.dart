import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/login_button.dart';
import 'package:admin_dashboard/components/textfield/cp_textfield.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/changepassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final controller = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Ganti Password",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// OLD PASSWORD
              ChangePasswordTextField(
                hintText: "Password Lama",
                isPassword: true,
                controller: controller.oldPasswordController,
                margin: const EdgeInsets.only(bottom: 16),
              ),

              /// NEW PASSWORD
              ChangePasswordTextField(
                hintText: "Password Baru",
                isPassword: true,
                controller: controller.newPasswordController,
                margin: const EdgeInsets.only(bottom: 35),
              ),

              /// BUTTON
              Obx(() {
                return DefaultButton(
                  text: controller.isLoading.value
                      ? "Loading..."
                      : "Ganti Password",
                  onPressed: () {
                    if (!controller.isLoading.value) {
                      controller.changePassword();
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
