import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  ReusableButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12)
            ),
            elevation: 0
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColor.white),
              Container(
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),
        ),
      ) 
    );
  }
}