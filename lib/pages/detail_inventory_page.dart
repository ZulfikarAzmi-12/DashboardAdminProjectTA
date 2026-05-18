import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/detail_inventory_button.dart';
import 'package:admin_dashboard/components/chip/detail_inventory_chip.dart';
import 'package:admin_dashboard/components/tile/detail_inventory_tile.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/detail_inventory_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventoryPage extends StatelessWidget {
  DetailInventoryPage({super.key});

  final DetailInventoryController controller =
      Get.find<DetailInventoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        title: '',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          // ── Loading state ────────────────────────────────────────────────
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }

          // ── Empty / error state ──────────────────────────────────────────
          final item = controller.itemDetail.value;
          if (item == null) {
            return const Center(
              child: Text(
                'Data tidak ditemukan',
                style: TextStyle(fontSize: 15, color: AppColor.gray),
              ),
            );
          }

          // ── Content ──────────────────────────────────────────────────────
          return CustomScrollView(
            slivers: [
              // ── Hero image ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: 260,
                  color: AppColor.white,
                  child: Image.network(
                    item.image.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 60,
                        color: AppColor.lightgray,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Info: nama, id, unit, chips ──────────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  color: AppColor.white,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama item
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blacktext,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ID Inventaris
                      _buildInfoRow(
                        label: 'ID Inventaris',
                        value: item.itemCode,
                      ),
                      const SizedBox(height: 6),

                      // Unit Tersedia
                      _buildInfoRow(
                        label: 'Unit Tersedia',
                        value: '${item.totalUnit}',
                      ),
                      const SizedBox(height: 14),

                      // Chips lokasi & kategori
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          DetailInventoryChip(
                            title: item.location.locationName,
                            icon: Icons.location_on,
                          ),
                          DetailInventoryChip(
                            title: item.category.categoryName,
                            icon: Icons.category_outlined,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Action Buttons: Nonaktifkan/Aktifkan & Edit ──────
                      Obx(
                        () => Row(
                          children: [
                            DetailInventoryButton(
                              title: item.isAvailable
                                  ? "Nonaktifkan"
                                  : "Aktifkan",
                              isLoading:
                                  controller.isTogglingAvailability.value,
                              onTap: controller.isTogglingAvailability.value
                                  ? () {}
                                  : () =>
                                        controller.toggleAvailability(item.id),
                            ),
                            const SizedBox(width: 12),
                            DetailInventoryButton(
                              title: 'Edit',
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.editPage,
                                  arguments: item,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Description ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  color: AppColor.white,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.gray,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Header "Unit" ────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Container(
                  color: AppColor.white,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Unit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                        ),
                      ),
                      // Badge jumlah unit
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${item.unit.length} unit',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── ListView unit ────────────────────────────────────────────
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final unit = item.unit[index];
                  // Hanya bisa dipilih kalau status "tersedia"
                  final bool isAvailable =
                      unit.status.toLowerCase() == 'tersedia';

                  return GestureDetector(
                    onTap: isAvailable
                        ? () => Get.toNamed(AppRoutes.loan, arguments: unit.id)
                        : null,
                    child: Opacity(
                      opacity: isAvailable ? 1.0 : 0.5,
                      child: DetailInventoryTile(unit: unit),
                    ),
                  );
                }, childCount: item.unit.length),
              ),

              // ── Bottom spacing ───────────────────────────────────────────
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        }),
      ),
    );
  }

  // ── Helper Widgets ─────────────────────────────────────────────────────────

  Widget _buildInfoRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          ':',
          style: TextStyle(fontSize: 14, color: AppColor.blacktext),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? AppColor.blacktext,
            fontWeight: valueColor != null
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
