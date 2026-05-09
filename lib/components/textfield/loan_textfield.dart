import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';


class LoanTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool readOnly;

  const LoanTextfield({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xffEAE6E6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColor.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}