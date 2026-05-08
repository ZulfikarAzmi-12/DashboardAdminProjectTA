import 'package:flutter/material.dart';

class FormTextField
    extends StatelessWidget {

  final String hint;
  final TextEditingController controller;

  const FormTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      height: 54,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color:
                Colors.black.withOpacity(0.05),

            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Center(
        child: TextField(
          controller: controller,

          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: hint,

            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}