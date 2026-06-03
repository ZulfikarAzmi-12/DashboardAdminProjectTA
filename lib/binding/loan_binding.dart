import 'package:admin_dashboard/controller/loan_controller.dart';
import 'package:get/get.dart';

class LoanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoanController>(() => LoanController(),);
  }

}