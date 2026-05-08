import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.lightgray,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TITLE
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            /// DESCRIPTION
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColor.blacktext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}