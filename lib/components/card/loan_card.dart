import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/utils/text_util.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final LoanData data;
  final VoidCallback onPresed;

  const LoanCard({super.key, required this.data, required this.onPresed});

  Color getStatusBackgroundColor() {
    switch (data.status.toLowerCase()) {
      case "pending":
        return const Color(0xFFE6E7EB);
      case "dipinjam":
        return const Color(0xFFDBFCE7);
      case "ditolak":
        return const Color(0xFFFEE2E1);
      case "terlambat":
        return const Color(0xFFFEF3C6);
      case "dikembalikan":
      case "kembali":
        return const Color(0xFFD9D9D9);
      default:
        return const Color(0xFFE6E7EB);
    }
  }

  Color getStatusTextColor() {
    switch (data.status.toLowerCase()) {
      case "pending":
        return const Color(0xFF6B7280);
      case "dipinjam":
        return const Color(0xFF16A34A);
      case "ditolak":
        return const Color(0xFFDC2626);
      case "terlambat":
        return const Color(0xFFD97706);
      case "dikembalikan":
      case "kembali":
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  bool get isDitolak => data.status.toLowerCase() == "ditolak";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPresed,
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: getStatusBackgroundColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.status,
                  style: TextStyle(
                    color: getStatusTextColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// Item Name
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  data.unit.item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),

              /// Borrower & Schedule
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    Text(
                      data.user.username,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.blacktext,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text("|", style: TextStyle(color: Colors.black26)),
                    ),
                    Expanded(
                      child: Text(
                        TextUtil.loanSchedule(
                          DateTime.parse(data.borrowedDate).toLocal(),
                          DateTime.parse(data.returnDate).toLocal(),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blacktext,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              /// Rejection Reason (only if ditolak)
              if (isDitolak &&
                  data.rejectionReason != null &&
                  data.rejectionReason!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(
                    data.rejectionReason!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.blacktext,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
