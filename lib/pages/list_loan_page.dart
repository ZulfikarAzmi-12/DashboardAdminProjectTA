import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/card/loan_card.dart';
import 'package:admin_dashboard/components/chip/inventaris_chip.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/list_loan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListLoanPage extends StatelessWidget {
  ListLoanPage({super.key});

  final controller = Get.find<ListLoanController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      appBar: CustomAppBar(
        title: "List Peminjaman",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () => Get.back(),
        ),
      ),

      body: Column(
        children: [
          /// FILTER CHIP
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 10),

            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(horizontal: 16),

              itemCount: controller.filters.length,

              itemBuilder: (context, index) {
                final filter = controller.filters[index];

                return Obx(
                  () => InventarisChip(
                    title: filter,

                    isSelected: controller.selectedFilter.value == filter,

                    onTap: () {
                      controller.changeFilter(filter);
                    },
                  ),
                );
              },
            ),
          ),

          /// LIST DATA
          Expanded(
            child: Obx(() {
              if (controller.filteredLoans.isEmpty) {
                return Center(
                  child: Text(
                    "Data tidak ditemukan",

                    style: TextStyle(color: AppColor.gray),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                itemCount: controller.filteredLoans.length,

                itemBuilder: (context, index) {
                  final data = controller.filteredLoans[index];

                  return LoanCard(data: data);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
