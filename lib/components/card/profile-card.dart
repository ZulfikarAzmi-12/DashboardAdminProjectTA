import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [

          // Avatar
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColor.blacktext,
            child: Icon(Icons.person, color: AppColor.background),
          ),

          const SizedBox(width: 12),

          // Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}