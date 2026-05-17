import 'package:admin_dashboard/components/button/home_button.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/utils/text_util.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final LoanData data;
  final VoidCallback onPresed;

  const LoanCard({super.key, required this.data, required this.onPresed});

  Color getStatusColor() {
    switch (data.status) {
      case "pending":
      case "Pending":
        return AppColor.pending;
      case "dipinjam":
      case "Dipinjam":
        return AppColor.dipinjam;
      case "dikembalikan":
      case "Dikembalikan":
        return AppColor.gray;
      case "terlambat":
      case "Terlambat":
      case "ditolak":
        return AppColor.terlambat;
      default:
        return AppColor.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),

      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: getStatusColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data.status,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),

                        Text(
                          data.loanCode,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        data.unit.item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColor.primary,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        "Dipinjam oleh: ${data.user.username}",
                        style: TextStyle(fontSize: 12, color: AppColor.gray),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        TextUtil.loanSchedule(
                          DateTime.parse(data.borrowedDate),
                          DateTime.parse(data.returnDate),
                        ),
                        style: TextStyle(color: AppColor.gray),
                      ),
                    ),

                    /// BUTTON
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      width: double.infinity,
                      child: HomeButton(
                        text: "Lihat Detail",
                        onPressed: onPresed,
                        isOutline: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
