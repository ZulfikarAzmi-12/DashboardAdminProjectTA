import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isOutline;

  const HomeButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isOutline = false, // 🔥 default: filled
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isOutline ? Colors.transparent : AppColor.primary,
        foregroundColor:
            isOutline ? AppColor.primary : AppColor.white,
        elevation: isOutline ? 0 : 2,
        side: isOutline
            ? BorderSide(color: AppColor.primary)
            : BorderSide.none,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),

      /// 🔥 CONTENT
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// ICON (optional)
          if (icon != null)
            Icon(
              icon,
              size: 20,
              color: isOutline ? AppColor.primary : AppColor.white,
            ),

          if (icon != null)
            Container(
              margin: EdgeInsets.only(left: 8),
            ),

          /// TEXT
          Text(
            text,
            style: TextStyle(
              color: isOutline ? AppColor.primary : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}