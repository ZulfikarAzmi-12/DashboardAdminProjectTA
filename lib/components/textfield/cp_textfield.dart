import 'package:flutter/material.dart';
import '../../constants/app_color.dart';

class ChangePasswordTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;

  const ChangePasswordTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.margin
  });

 @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline, size: 20),

          isDense: true, // 🔥 bikin lebih compact
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14, // 🔥 ini yang bikin slim
            horizontal: 12,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}