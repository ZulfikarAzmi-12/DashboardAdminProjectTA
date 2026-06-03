import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class DetailLoanStatus extends StatelessWidget {
  final String status;

  const DetailLoanStatus({super.key, required this.status});

  Color get _statusColor {
    switch (status.toLowerCase()) {
      case "pending":
        return AppColor.pending;
      case "dipinjam":
        return AppColor.dipinjam;
      case "terlambat":
        return AppColor.terlambat;
      case "ditolak":
        return AppColor.terlambat;
      case "dikembalikan":
        return AppColor.gray;
      default:
        return AppColor.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: _statusColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: AppColor.background,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
