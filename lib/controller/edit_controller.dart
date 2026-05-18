import 'dart:io';

import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditController extends GetxController {
  final InventarisService inventarisService = InventarisService();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final RxString selectedCategory = ''.obs;
  final RxString selectedLocation = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  final RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingLocation = false.obs;

  var categoryList = <CategoryModel>[].obs;
  var locationList = <LocationModel>[].obs;

  ItemDetailModel? item;

  // ── ON INIT ─────────────────────────────
  @override
  void onInit() {
    super.onInit();

    fetchCategories();
    fetchLocations();

    // ambil arguments dari GetX
    item = Get.arguments as ItemDetailModel?;

    if (item != null) {
      initForm(item!);
    }
  }

  void initForm(ItemDetailModel item) {
    namaController.text = item.name;
    descController.text = item.description;
    selectedCategory.value = item.category.id;
    selectedLocation.value = item.location.id;
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategory.value = true;
      categoryList.value = await inventarisService.getCategories();
    } finally {
      isLoadingCategory.value = false;
    }
  }

  Future<void> fetchLocations() async {
    try {
      isLoadingLocation.value = true;
      locationList.value = await inventarisService.getLocations();
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> updateItem() async {
    if (item == null) return;

    try {
      isLoadingUpdate.value = true;

      await inventarisService.updateItem(
        itemId: item!.id,
        name: namaController.text,
        description: descController.text,
        categoryId: selectedCategory.value,
        locationId: selectedLocation.value,
        image: selectedImage.value,
      );

      Get.back();

      Get.snackbar("Success", "Berhasil update item");
    } catch (e) {
      Get.snackbar("Error", "Gagal update item");
    } finally {
      isLoadingUpdate.value = false;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    descController.dispose();
    super.onClose();
  }
}
