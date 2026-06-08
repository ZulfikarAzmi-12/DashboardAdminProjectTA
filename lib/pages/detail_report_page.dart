import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/long_button.dart';
import 'package:admin_dashboard/components/card/loan_detail_card.dart';
import 'package:admin_dashboard/components/status/detail_loan_status.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/detail_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailReportPage extends StatelessWidget {
  DetailReportPage({super.key});

  final controller = Get.find<DetailReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: 'Detail Report',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.report.value;

          if (data == null) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailLoanStatus(status: data.status),

                Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: LoanDetailCard(
                    itemName: data.unit.itemName,
                    itemCode: data.unit.itemUnitCode,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: const Text(
                    'Pelapor :',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    data.user.username,
                    style: const TextStyle(
                      color: AppColor.blacktext,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: const Text(
                    'Aduan :',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      color: AppColor.blacktext,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),

                if (data.status != 'selesai')
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: LongButton(
                      text: controller.buttonLabel,
                      backgroundColor: controller.isPending
                          ? AppColor.pending
                          : AppColor.primary,
                      onPressed: controller.processReport,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
