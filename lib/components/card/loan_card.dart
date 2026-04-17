import 'package:admin_dashboard/components/button/home_button.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/loan_models.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final LoanModel data;

  const LoanCard({super.key, required this.data});

  Color getStatusColor() {
    switch (data.status) {
      case "Pending":
        return AppColor.pending;
      case "Dipinjam":
        return AppColor.dipinjam;
      case "Dikembalikan":
        return AppColor.gray;
      case "Terlambat":
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
          BoxShadow(
            color: AppColor.blacktext,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),

      /// 🔥 FIX HEIGHT ISSUE
      child: IntrinsicHeight(
        child: Row(
          children: [

            /// 🔥 GARIS KIRI
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

            /// 🔥 ISI CARD
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// STATUS + KODE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: getStatusColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data.status,
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        Text(
                          data.kode,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    /// NAMA
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        data.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColor.primary,
                        ),
                      ),
                    ),

                    /// TANGGAL
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14),
                          Container(
                            margin: EdgeInsets.only(left: 6),
                            child: Text(
                              data.tanggal,
                              style: TextStyle(color: AppColor.gray),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// BUTTON
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      width: double.infinity,
                      child: HomeButton(
                        text: "Lihat Detail",
                        onPressed: () {},
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