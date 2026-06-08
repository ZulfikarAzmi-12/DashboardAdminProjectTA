import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/detail_loan_button.dart';
import 'package:admin_dashboard/components/card/detail_loan_card.dart';
import 'package:admin_dashboard/components/card/inventory_loan_card.dart';
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
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: '',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primary),
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
                      // 1. Inventory Card
                      InventoryLoanCard(
                        itemName: loan.itemName,
                        itemCode: loan.itemCode,
                        imageUrl: loan.imageUrl,
                      ),
                      const SizedBox(height: 12),

                      // 2. Peminjam Card
                      _buildBorrowerCard(loan),
                      const SizedBox(height: 12),

                      // 3. Detail Peminjaman Card
                      DetailLoanCard(
                        loanCode: loan.loanCode,
                        status: loan.status,
                        borrowDate: loan.borrowDate,
                        returnDate: loan.returnDate,
                        loanPurpose: loan.loanPurpose,
                        acctualReturnDate: loan.actualReturnDate,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // 4. Action Buttons
              Obx(() => _buildActionButtons(loan.status)),
            ],
          ),
        );
      }),
    );
  }

  /// Card Peminjam (nama + telepon)
  Widget _buildBorrowerCard(loan) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Peminjam',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.blacktext,
            ),
          ),
          const SizedBox(height: 12),
          _infoRow('Nama :', loan.borrowerName),
          const SizedBox(height: 8),
          _infoRow('Telpon :', loan.borrowerPhone),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.blacktext,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
      case "pending":
        return Row(
          children: [
            Expanded(
              child: DetailLoanButton(
                title: 'Tolak',
                backgroundColor: const Color(0xFFFEE2E1),
                textColor: const Color(0xFF424242),
                onTap: controller.rejectLoan,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DetailLoanButton(
                title: 'Setujui',
                backgroundColor: const Color(0xFFDBFCE7),
                textColor: const Color(0xFF424242),
                onTap: controller.approveLoan,
              ),
            ),
          ],
        );

      case "dipinjam":
      case "terlambat":
        return SizedBox(
          width: double.infinity,
          child: DetailLoanButton(
            title: 'Pengembalian',
            backgroundColor: AppColor.dipinjam,
            textColor: Colors.white,
            onTap: controller.returnLoan,
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
