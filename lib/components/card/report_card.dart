import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/report_model.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final ReportModel data;

  const ReportCard({super.key, required this.data});

  Color getStatusColor() {
    switch (data.status) {
      case "Pending":
        return AppColor.pending;
      case "Diproses":
        return AppColor.dipinjam;
      case "Selesai":
        return AppColor.gray;
      default:
        return AppColor.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATUS
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getStatusColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              data.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // TITLE
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              data.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
            ),
          ),

          // CODE
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(data.code, style: TextStyle(fontWeight: FontWeight.bold,color:  AppColor.primary)),
          ),

          const Divider(),

          // LABEL
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 4),
            child: const Text(
              "Aduan :",
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primary),
            ),
          ),

          // CONTENT
          Text(data.complaint),
        ],
      ),
    );
  }
}
