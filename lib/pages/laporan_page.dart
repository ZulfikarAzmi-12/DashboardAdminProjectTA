import 'package:admin_dashboard/components/card/report_card.dart';
import 'package:admin_dashboard/components/chip/inventeris_chip.dart';
import 'package:admin_dashboard/components/navbar/reusable_navbar.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final controller = Get.find<ReportController>();

  final List<String> filters = [
    "All",
    "Pending",
    "Diproses",
    "Selesai",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= TITLE =================
            Container(
              margin: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
              child: const Text(
                "Laporan Kerusakan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ================= FILTER CHIP =================
            Container(
              margin: const EdgeInsets.only(left: 16),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Obx(() => InventarisChip(
                        title: filters[index],
                        isSelected:
                            controller.selectedFilter.value == filters[index],
                        onTap: () {
                          controller.applyFilter(filters[index]);
                        },
                      ));
                },
              ),
            ),

            // ================= LIST =================
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.filteredReports.isEmpty) {
                  return const Center(
                    child: Text("Data tidak ditemukan"),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredReports.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredReports[index];

                    return ReportCard(data: item);
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