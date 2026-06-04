import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventarisController extends GetxController {
  final InventarisService service = InventarisService();

  var selectedCategory = "All".obs;
  var searchQuery = "".obs;
  var categories = <String>[].obs;

  var inventories = <InventoryModel>[].obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchInventories();
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    isLoading.value = true;

    try {
      final result = await service.getCategories();

      // ── Reset dulu sebelum assign supaya tidak duplikat saat refresh ──
      categories.clear();
      categories.value = ["All", ...result.map((e) => e.categoryName)];

      // Reset selected ke "All" hanya kalau value sekarang tidak ada di list baru
      if (!categories.contains(selectedCategory.value)) {
        selectedCategory.value = "All";
      }
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      print("error fetchCategories: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }

    isLoading.value = false;
  }

  void fetchInventories() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await service.getInventories();

      inventories.value = result;
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }

    isLoading.value = false;
  }

  List<InventoryModel> get filteredItems {
    var result = inventories;

    // FILTER CATEGORY
    if (selectedCategory.value != "All") {
      result = result
          .where((e) => e.category.categoryName == selectedCategory.value)
          .toList()
          .obs;
    }

    // FILTER SEARCH
    if (searchQuery.value.isNotEmpty) {
      result = result
          .where(
            (e) =>
                e.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
          )
          .toList()
          .obs;
    }

    return result;
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
