import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/report_model.dart';
import 'package:admin_dashboard/services/detail_report_service.dart';
import 'package:get/get.dart';

class DetailReportController extends GetxController {
  final isLoading = true.obs;
  final report = Rxn<DamageReportModel>();
  final _service = DetailReportService();
  @override
  void onInit() {
    super.onInit();
    _loadReportFromArguments();
  }

  void _loadReportFromArguments() {
    final args = Get.arguments;
    if (args is DamageReportModel) {
      report.value = args;
    }
    isLoading.value = false;
  }

  bool get isPending => report.value?.status.toLowerCase() == 'pending';

  String get buttonLabel => isPending ? 'Proses' : 'Selesai';

  Future<void> processReport() async {
    try {
      final data = report.value;
      if (data == null) return;

      final message = await _service.updateReportStatus(
        reportId: data.id,
        currentStatus: data.status,
      );

      // Update status lokal tanpa perlu reload
      report.value = DamageReportModel(
        id: data.id,
        title: data.title,
        status: data.status.toLowerCase() == 'pending' ? 'diproses' : 'selesai',
        user: data.user,
        unit: data.unit,
      );

      Get.snackbar('Berhasil', message);
    } catch (e) {
      if (e is AppError) {
        Get.snackbar('Gagal', e.message);
      }
    }
  }
}
