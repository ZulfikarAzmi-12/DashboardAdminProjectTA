/// =======================================
/// CARD
/// components/card/loan_card.dart
/// =======================================

import 'package:admin_dashboard/components/button/home_button.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/list_loan_model.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:flutter/material.dart';

class ListLoanCard extends StatelessWidget {
  final ListLoanModel data;

  const ListLoanCard({
    super.key,
    required this.data,
  });

  Color getStatusColor() {

    switch (data.status.toLowerCase()) {

      case "pending":
        return AppColor.pending;

      case "dipinjam":
        return AppColor.dipinjam;

      case "dikembalikan":
        return AppColor.gray;

      case "terlambat":
      case "ditolak":
        return AppColor.terlambat;

      default:
        return AppColor.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),

      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(14),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: IntrinsicHeight(
        child: Row(
          children: [

            /// LEFT INDICATOR
            Container(
              width: 4,

              decoration: BoxDecoration(
                color: getStatusColor(),

                borderRadius:
                    const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    /// STATUS & CODE
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: getStatusColor(),

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            data.status,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),

                        Text(
                          data.code,

                          style: TextStyle(
                            color:
                                AppColor.primary,

                            fontWeight:
                                FontWeight.w600,

                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    /// ITEM NAME
                    Container(
                      margin:
                          const EdgeInsets.only(
                        top: 14,
                      ),

                      child: Text(
                        data.name,

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,

                          fontSize: 16,

                          color:
                              AppColor.primary,
                        ),
                      ),
                    ),

                    /// DATE
                    Container(
                      margin:
                          const EdgeInsets.only(
                        top: 6,
                      ),

                      child: Row(
                        children: [

                          Icon(
                            Icons.event,
                            size: 14,
                            color: AppColor.primary,
                          ),

                          const SizedBox(
                            width: 4,
                          ),

                          Text(
                            data.returnDate,

                            style: TextStyle(
                              color:
                                  AppColor.primary,

                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// BUTTON
                    Container(
                      margin:
                          const EdgeInsets.only(
                        top: 14,
                      ),

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