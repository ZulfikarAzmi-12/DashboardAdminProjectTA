import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/services/detail_inventory_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventoryController extends GetxController {
  final DetailInventoryService _inventoryService = DetailInventoryService();

  // ── State ──────────────────────────────────────────────────────────────────
  final Rx<ItemDetailModel?> itemDetail = Rx<ItemDetailModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isTogglingAvailability = false.obs;

  late String itemId;
  @override
  void onInit() {
    // TODO: implement onInit
    itemId = Get.arguments as String;
    fetchItemDetail(itemId);
    super.onInit();
  }

  // ── Fetch Detail ───────────────────────────────────────────────────────────
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

  // ── Toggle Availability ────────────────────────────────────────────────────
  void toggleAvailability(String itemId) async {
    try {
      isTogglingAvailability.value = true;

      // Ambil status saat ini dari itemDetail, default false kalau null
      final currentStatus = itemDetail.value?.isAvailable ?? false;

      final message = await _inventoryService.toggleItemAvailability(
        itemId,
        currentStatus,
      );

      // Refresh detail supaya status terbaru langsung tampil
      await _refreshItemDetail(itemId);

      Get.snackbar(
        "Berhasil",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    } on AppError catch (e) {
      String message = e.message;
      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"] as String;
      }
      Get.snackbar(
        "Gagal Mengubah Status",
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
      isTogglingAvailability.value = false;
    }
  }

  // ── Private: silent refresh setelah toggle ─────────────────────────────────
  Future<void> _refreshItemDetail(String itemId) async {
    try {
      final result = await _inventoryService.getItemDetail(itemId);
      itemDetail.value = result;
    } catch (_) {
      // Gagal refresh tidak perlu snackbar — data lama tetap tampil
    }
  }
}
