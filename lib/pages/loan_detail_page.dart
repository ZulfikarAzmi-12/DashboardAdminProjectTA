import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/detail_loan_button.dart';
import 'package:admin_dashboard/components/card/detail_loan_card.dart';
import 'package:admin_dashboard/components/card/inventory_loan_card.dart';
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.loanData.value == null) {
          return const Center(child: Text("Data tidak ditemukan"));
        }

        final loan = controller.loanData.value!;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// STATUS + LOAN CODE (Header)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailLoanStatus(status: loan.status),
                          Text(
                            loan.loanCode,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      InventoryLoanCard(
                        itemName: loan.itemName,
                        itemCode: loan.itemCode,
                        imageUrl: loan.imageUrl,
                      ),
                      const SizedBox(height: 20),

                      DetailLoanCard(
                        borrowerName: loan.borrowerName,
                        borrowerPhone: loan.borrowerPhone,
                        borrowDate: loan.borrowDate,
                        returnDate: loan.returnDate,
                        loanPurpose: loan.loanPurpose,
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),

              _buildActionButtons(loan.status),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons(String status) {
    if (controller.isActionLoading.value) {
      return const SizedBox(
        height: 52,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    switch (status.toLowerCase()) {
      // ── Pending → Tolak + Setujui
      case "pending":
        return Row(
          children: [
            Expanded(
              child: DetailLoanButton(
                title: 'Tolak',
                backgroundColor: AppColor.primary,
                onTap: () {
                  controller.rejectLoan();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DetailLoanButton(
                title: 'Setujui',
                backgroundColor: AppColor.dipinjam,
                onTap: () {
                  controller.approveLoan();
                },
              ),
            ),
          ],
        );
      // ── Dipinjam / Terlambat → Pengembalian ──────────────────────────
      case "dipinjam":
      case "terlambat":
        return SizedBox(
          width: double.infinity,
          child: DetailLoanButton(
            title: 'Pengembalian',
            backgroundColor: AppColor.dipinjam,
            onTap: () {
              controller.returnLoan();
            },
          ),
        );

      case "dikembalikan":
      case "ditolak":
        return const SizedBox.shrink();

      default:
        return const SizedBox.shrink();
    }
  }
}
