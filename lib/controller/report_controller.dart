import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/report_model.dart';
import 'package:admin_dashboard/services/report_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final ReportService service = ReportService();

  var reports = <DamageReportModel>[].obs;
  var filteredReports = <DamageReportModel>[].obs;

  var selectedFilter = "All".obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final filters = ["All", "pending", "diproses", "selesai"];

  @override
  void onInit() {
    fetchReports();
    super.onInit();
  }

  Future<void> fetchReports() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await service.getDamageReports();

      print(result.length);

      reports.value = result;

      applyFilter("All");
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
      print("error rek $e");

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
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter(String filter) {
    selectedFilter.value = filter;

    if (filter == "All") {
      filteredReports.value = reports;
    } else {
      filteredReports.value = reports.where((e) {
        return e.status.toLowerCase() == filter.toLowerCase();
      }).toList();
    }
  }
}
