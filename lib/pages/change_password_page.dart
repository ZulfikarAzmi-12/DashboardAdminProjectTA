import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/textfield/cp_textfield.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Ganti Password",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangePasswordTextField(
                hintText: "Password Lama",
                isPassword: true,
                margin: const EdgeInsets.only(bottom: 16),
              ),

              ChangePasswordTextField(
                hintText: "Password Baru",
                isPassword: true,
                margin: const EdgeInsets.only(bottom: 35),
              ),

              BigButton(title: "Ganti Password", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
