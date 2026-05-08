import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInventoryController extends GetxController {

  final namaController = TextEditingController();
  final descController = TextEditingController();
  final jumlahController = TextEditingController();

  final selectedCategory = ''.obs;
  final selectedLocation = ''.obs;

  final categoryList = [
    "Elektronik",
    "Fotografi",
    "Mesin",
  ];

  final locationList = [
    "Gudang A",
    "Gudang B",
    "Gudang C",
  ];

  @override
  void onClose() {
    namaController.dispose();
    descController.dispose();
    jumlahController.dispose();
    super.onClose();
  }
}