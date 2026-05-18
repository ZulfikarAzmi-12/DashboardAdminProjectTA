import 'package:admin_dashboard/models/detail_report_model.dart';
import 'package:admin_dashboard/services/detail_report_service.dart';
import 'package:get/get.dart';

class DetailReportController extends GetxController {
  final DetailReportService _service = DetailReportService();

  final isLoading = true.obs;

  final loanDetail = Rxn<DetailReportModel>();

  @override
  void onInit() {
    getLoanDetail();
    super.onInit();
  }

  Future<void> getLoanDetail() async {
    try {
      isLoading.value = true;

      final response = await _service.getLoanDetail();

      loanDetail.value = response;
    } finally {
      isLoading.value = false;
    }
  }

  void processLoan() {
    // action button
  }
}