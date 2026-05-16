import 'package:admin_dashboard/controller/loan_detail_controller.dart';
import 'package:get/get.dart';

class DetailLoanBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoanDetailController>(() => LoanDetailController(),);
  }

}