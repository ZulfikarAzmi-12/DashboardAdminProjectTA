import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/card/report_card.dart';
import 'package:admin_dashboard/components/chip/inventaris_chip.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/report_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final ReportController controller = Get.find<ReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Inventaris",
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColor.primary),
            onPressed: () {
              Get.toNamed(AppRoutes.notification);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= TITLE =================
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 12),
              child: Text(
                "Laporan Kerusakan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // ================= FILTER =================
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.filters.length,
                itemBuilder: (context, index) {
                  final filter = controller.filters[index];

                  return Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InventarisChip(
                        title: filter,
                        isSelected: controller.selectedFilter.value == filter,
                        onTap: () {
                          controller.applyFilter(filter);
                        },
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 10),

            // ================= LIST =================
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredReports.isEmpty) {
                  return const Center(child: Text("Data tidak ditemukan"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredReports.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredReports[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ReportCard(data: item),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
