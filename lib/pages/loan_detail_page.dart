import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/detail_loan_button.dart';
import 'package:admin_dashboard/components/card/loan_detail_card.dart';
import 'package:admin_dashboard/components/status/detail_loan_info.dart';
import 'package:admin_dashboard/components/status/detail_loan_status.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/loan_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanDetailPage extends StatelessWidget {
  LoanDetailPage({super.key});

  final controller = Get.find<LoanDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: CustomAppBar(
        title: "Detail Peminjaman",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () => Get.back(),
        ),
      ),

      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// STATUS + CODE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailLoanStatus(
                            status: controller.loanData.value.status,
                          ),

                          Text(
                            controller.loanData.value.loanCode,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B2E28),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// DATE SECTION
                      Row(
                        children: [
                          Expanded(
                            child: DetailLoanInfo(
                              title: 'Tgl Pinjam',
                              value: controller.loanData.value.borrowDate,
                              icon: Icons.calendar_today,
                            ),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            child: DetailLoanInfo(
                              title: 'Tgl Kembali',
                              value: controller.loanData.value.returnDate,
                              icon: Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// ITEM CARD
                      LoanDetailCard(
                        itemName: controller.loanData.value.itemName,
                        itemCode: controller.loanData.value.itemCode,
                        imageUrl: controller.loanData.value.imageUrl,
                      ),

                      const SizedBox(height: 28),

                      /// BORROWER
                      DetailLoanInfo(
                        title: 'Peminjam :',
                        value:
                            '${controller.loanData.value.borrowerName}\n'
                            '${controller.loanData.value.borrowerPhone}',
                        isColumn: true,
                      ),

                      const SizedBox(height: 24),

                      /// PURPOSE
                      DetailLoanInfo(
                        title: 'Dipinjam Untuk :',
                        value: controller.loanData.value.loanPurpose,
                        isColumn: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTON SECTION
              Row(
                children: [
                  Expanded(
                    child: DetailLoanButton(
                      title: 'Tolak',
                      backgroundColor: AppColor.primary,
                      onTap: controller.rejectLoan,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: DetailLoanButton(
                      title: 'Setujui',
                      backgroundColor: AppColor.dipinjam,
                      onTap: controller.approveLoan,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
