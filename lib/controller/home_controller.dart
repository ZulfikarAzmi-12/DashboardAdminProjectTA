import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/home_model.dart';
import 'package:admin_dashboard/services/loan_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/services/home_service.dart';

class HomeController extends GetxController {
  final HomeService service = HomeService();
  final LoanService loanService = LoanService();

  var loans = <LoanData>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var summary = Rxn<SummaryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchLoans();
    fetchSummary();
  }

  Future<void> fetchLoans() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await loanService.getLoans();
      loans.value = result.take(3).toList();
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
      print("error rek $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSummary() async {
    try {
      final result = await service.getSummary();
      summary.value = result;
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
      print("error rel $e");
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
  }

  // ── Dipanggil RefreshIndicator — fetch semua sekaligus ────────────────
  Future<void> refresh() => Future.wait([fetchSummary(), fetchLoans()]);
}
