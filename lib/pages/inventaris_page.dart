import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/custom_fab.dart';
import 'package:admin_dashboard/components/button/reusable_button.dart';
import 'package:admin_dashboard/components/card/inventaris_card.dart';
import 'package:admin_dashboard/components/chip/inventaris_chip.dart';
import 'package:admin_dashboard/components/search/search_field.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/inventaris_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisPage extends StatelessWidget {
  InventarisPage({super.key});

  final controller = Get.find<InventarisController>();

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
          children: [
            // ================= TOP BUTTON =================
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ReusableButton(
                      text: "Kelola Lokasi",
                      onTap: () {
                        Get.toNamed(AppRoutes.location);
                      },
                    ),
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
            SearchField(
              onChanged: (value) {
                controller.updateSearch(value);
              },
            ),

            // ================= CHIP + LIST (dibungkus RefreshIndicator) =================
            Expanded(
              child: RefreshIndicator(
                color: AppColor.primary,
                onRefresh: () async {
                  controller.fetchCategories();
                  controller.fetchInventories();
                },
                child: ListView(
                  children: [
                    // ================= CATEGORY CHIP =================
                    Container(
                      margin: const EdgeInsets.only(top: 12, left: 16),
                      height: 52,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => InventarisChip(
                              title: controller.categories[index],
                              isSelected:
                                  controller.selectedCategory.value ==
                                  controller.categories[index],
                              onTap: () {
                                controller.selectedCategory.value =
                                    controller.categories[index];
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
                        return const Center(
                          child: Text("Data tidak ditemukan"),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.filteredItems[index];
                          return GestureDetector(
                            onTap: () => Get.toNamed(
                              AppRoutes.detailInventory,
                              arguments: item.id,
                            ),
                            child: InventarisCard(item: item),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ================= FAB =================
      floatingActionButton: CustomFAB(
        onPressed: () {
          Get.toNamed(AppRoutes.addInventory);
        },
        icon: Icons.add,
      ),
    );
  }
}
