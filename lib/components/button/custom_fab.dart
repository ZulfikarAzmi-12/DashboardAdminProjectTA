import 'package:flutter/material.dart';
import 'package:admin_dashboard/constants/app_color.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final double radius;

  const CustomFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 56,
    this.radius = 16, // sudut rounded
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AppColor.primary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              color: AppColor.primary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}