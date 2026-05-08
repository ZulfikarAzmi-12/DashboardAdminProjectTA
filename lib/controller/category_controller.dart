import 'package:admin_dashboard/models/category_model.dart';
import 'package:admin_dashboard/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryController
    extends GetxController {

  final CategoryService _service =
      CategoryService();

  final categoryTextController =
      TextEditingController();

  final categoryList =
      <CategoryModel>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {

    final data =
        await _service.getCategories();

    categoryList.value = data;
  }

  @override
  void onClose() {
    categoryTextController.dispose();
    super.onClose();
  }
}