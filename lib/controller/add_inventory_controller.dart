import 'dart:io';

import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddInventoryController extends GetxController {
  final InventarisService inventarisService = InventarisService();

  final namaController = TextEditingController();
  final descController = TextEditingController();
  final jumlahController = TextEditingController();

  // menyimpan ID
  final selectedCategory = ''.obs;
  final selectedLocation = ''.obs;

  // data dari API
  var categoryList = <CategoryModel>[].obs;
  var locationList = <LocationModel>[].obs;

  final ImagePicker picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);

  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchCategories();
    fetchLocations();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategory.value = true;

      final categories = await inventarisService.getCategories();

      categoryList.value = categories;
    } on AppError catch (e) {
      Get.snackbar("Error", e.message, snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan category",
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoadingCategory.value = false;
    }
  }

  Future<void> fetchLocations() async {
    try {
      isLoadingLocation.value = true;

      final locations = await inventarisService.getLocations();

      locationList.value = locations;
    } on AppError catch (e) {
      Get.snackbar("Error", e.message, snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan location",
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  RxBool isLoadingCreate = false.obs;

  Future<void> createInventory() async {
    try {
      isLoadingCreate.value = true;

      await inventarisService.createInventory(
        name: namaController.text,
        description: descController.text,
        categoryId: selectedCategory.value,
        locationId: selectedLocation.value,
        initialStock: jumlahController.text,
        image: selectedImage.value!,
      );

      Get.back();

      Get.snackbar(
        "Success",
        "Berhasil menambahkan inventory",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // reset form
      namaController.clear();
      descController.clear();
      jumlahController.clear();

      selectedCategory.value = '';
      selectedLocation.value = '';

      selectedImage.value = null;
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
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingCreate.value = false;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    descController.dispose();
    jumlahController.dispose();

    super.onClose();
  }
}
