import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class DetailLoanStatus extends StatelessWidget {
  final String status;

  const DetailLoanStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColor.pending,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: AppColor.background,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}