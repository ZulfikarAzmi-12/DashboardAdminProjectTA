import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/category_service.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryService service = CategoryService();
  final InventarisService inventarisService = InventarisService();

  final categoryTextController = TextEditingController();

  var categoryList = <CategoryModel>[].obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await inventarisService.getCategories();

      categoryList.value = result;
    } on AppError catch (e) {
      isError.value = true;

      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      errorMessage.value = message;

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      isError.value = true;
      errorMessage.value = "Terjadi kesalahan";

      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }

    isLoading.value = false;
  }

  Future<void> createCategory() async {
    try {
      final categoryName = categoryTextController.text.trim();

      if (categoryName.isEmpty) {
        Get.snackbar(
          "Error",
          "Nama category wajib diisi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFFA726),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
        );

        return;
      }

      final result = await service.createCategory(categoryName);

      categoryList.insert(0, result);

      categoryTextController.clear();

      Get.snackbar(
        "Success",
        "Berhasil menambahkan category",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  Future<void> updateCategory({
    required String categoryId,
    required String categoryName,
  }) async {
    try {
      if (categoryName.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Nama category wajib diisi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFFA726),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
        );

        return;
      }

      final result = await service.updateCategory(
        categoryId: categoryId,
        categoryName: categoryName,
      );

      final index = categoryList.indexWhere((e) => e.id == categoryId);

      if (index != -1) {
        categoryList[index] = result;
        categoryList.refresh();
      }

      Get.snackbar(
        "Success",
        "Berhasil update category",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  @override
  void onClose() {
    categoryTextController.dispose();
    super.onClose();
  }
}
