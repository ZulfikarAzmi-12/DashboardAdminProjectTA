import 'package:admin_dashboard/controller/report_controller.dart';
import 'package:get/get.dart';

class ReportBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController(),);
  }
}