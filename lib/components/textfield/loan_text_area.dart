import 'package:flutter/material.dart';

class LoanTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const LoanTextArea({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ),
    );
  }
}
