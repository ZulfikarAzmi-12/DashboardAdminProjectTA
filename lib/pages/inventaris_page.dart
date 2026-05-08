import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/custom_fab.dart';
import 'package:admin_dashboard/components/button/reusable_button.dart';
import 'package:admin_dashboard/components/card/inventaris_card.dart';
import 'package:admin_dashboard/components/chip/inventeris_chip.dart';
import 'package:admin_dashboard/components/search/search_field.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/inventaris_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisPage extends StatelessWidget {
  InventarisPage({super.key});

  final controller = Get.find<InventarisController>();

  final List<String> categories = ["All", "Elektronik", "Fotografi", "Mesin"];

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
        child: ListView(
          children: [
            // ================= TOP BUTTON =================
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ReusableButton(text: "Kelola Lokasi", onTap: () {
                      Get.toNamed(AppRoutes.location);
                    }),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ReusableButton(
                      text: "Kelola Kategori",
                      onTap: () {
                        Get.toNamed(AppRoutes.category);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ================= SEARCH =================
            const SearchField(),

            // ================= CATEGORY CHIP =================
            Container(
              margin: const EdgeInsets.only(top: 12, left: 16),
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InventarisChip(
                      title: categories[index],
                      isSelected:
                          controller.selectedCategory.value ==
                          categories[index],
                      onTap: () {
                        controller.selectedCategory.value = categories[index];
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ================= LIST =================
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredItems.isEmpty) {
                return const Center(child: Text("Data tidak ditemukan"));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = controller.filteredItems[index];
                  return InventarisCard(item: item);
                },
              );
            }),
          ],
        ),
      ),
      // ================= FAB =================
      floatingActionButton: CustomFAB(
        onPressed: () {
          Get.toNamed(AppRoutes.addInventory);
        }, 
        icon: Icons.add
      ),
    );
  }
}
