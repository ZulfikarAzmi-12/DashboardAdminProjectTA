import 'package:admin_dashboard/controller/detail_report_controller.dart';
import 'package:get/get.dart';

class DetailReportBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DetailReportController>(() => DetailReportController(),);
  }
}