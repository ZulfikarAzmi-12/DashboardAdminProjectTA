import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final String value;


  const ReusableCard({
    super.key,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blacktext.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0,4)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: AppColor.gray),),
            Container(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  AppColor.primary
                ),
              ),
            )
          ],
      ),
    );
  }
}