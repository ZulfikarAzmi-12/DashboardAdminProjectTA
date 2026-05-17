import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/services/detail_inventory_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventoryController extends GetxController {
  final DetailInventoryService _inventoryService = DetailInventoryService();

  // ── Observable state ──────────────────────────────────────────────────────
  final isLoading = false.obs;
  final Rx<ItemDetailModel?> itemDetail = Rx<ItemDetailModel?>(null);

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    final String itemId = Get.arguments as String;
    fetchItemDetail(itemId);
  }

  // ── Fetch detail ──────────────────────────────────────────────────────────
  void fetchItemDetail(String itemId) async {
    try {
      isLoading.value = true;
      final result = await _inventoryService.getItemDetail(itemId);
      itemDetail.value = result;
    } on AppError catch (e) {
      String message = e.message;
      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"] as String;
      }
      Get.snackbar(
        "Gagal Memuat Data",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan, coba lagi nanti",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
