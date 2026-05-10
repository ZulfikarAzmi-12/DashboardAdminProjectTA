import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/services/loan_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListLoanController extends GetxController {
  final LoanService service = LoanService();

  /// ACTIVE FILTER
  RxString selectedFilter = "All".obs;

  /// DATA
  RxList<LoanData> loans = <LoanData>[].obs;

  /// LOADING
  RxBool isLoading = false.obs;

  /// FILTER
  final List<String> filters = [
    "All",
    "Pending",
    "Dipinjam",
    "Dikembalikan",
    "Terlambat",
  ];

  @override
  void onInit() {
    super.onInit();

    fetchLoans();
  }

  /// CHANGE FILTER
  void changeFilter(String value) {
    selectedFilter.value = value;
  }

  /// FETCH API
  void fetchLoans() async {
    try {
      isLoading.value = true;

      final result = await service.getLoans();

      loans.assignAll(result);
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// FILTER RESULT
  List<LoanData> get filteredLoans {
    if (selectedFilter.value == "All") {
      return loans;
    }

    return loans.where((item) {
      return item.status.toLowerCase() == selectedFilter.value.toLowerCase();
    }).toList();
  }
}
