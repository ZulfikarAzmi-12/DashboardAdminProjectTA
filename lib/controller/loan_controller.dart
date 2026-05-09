import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  final borrowDateC = TextEditingController();
  final returnDateC = TextEditingController();
  final purposeC = TextEditingController();

  final selectedBorrower = ''.obs;

  final borrowerOptions = [
    'Zulfikar',
    'Azmi',
    'Admin',
  ];

  @override
  void onClose() {
    borrowDateC.dispose();
    returnDateC.dispose();
    purposeC.dispose();
    super.onClose();
  }
}