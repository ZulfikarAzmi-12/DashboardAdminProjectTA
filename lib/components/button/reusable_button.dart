import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const ReusableButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColor.white, size: 18),
          Container(margin: const EdgeInsets.only(left: 8)),
          Text(
            text,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}