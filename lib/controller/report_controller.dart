import 'package:admin_dashboard/models/report_model.dart';
import 'package:admin_dashboard/services/report_services.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final service = ReportService();

  var reports = <ReportModel>[].obs;
  var filteredReports = <ReportModel>[].obs;
  var selectedFilter = "All".obs;
  var isLoading = false.obs;

  final filters = ["All", "Pending", "Diproses", "Selesai"];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading.value = true;
    final data = await service.fetchReports();
    reports.value = data;
    applyFilter("All");
    isLoading.value = false;
  }

  void applyFilter(String filter) {
    selectedFilter.value = filter;

    if (filter == "All") {
      filteredReports.value = reports;
    } else {
      filteredReports.value =
          reports.where((e) => e.status == filter).toList();
    }
  }
}