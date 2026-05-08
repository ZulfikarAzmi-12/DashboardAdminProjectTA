import 'package:flutter/material.dart';

class AdduserTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AdduserTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            isCollapsed: true, // 🔥 penting biar height fix
          ),
        ),
      ),
    );
  }
}