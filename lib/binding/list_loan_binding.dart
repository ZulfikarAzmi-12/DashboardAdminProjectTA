import 'package:admin_dashboard/controller/list_loan_controller.dart';
import 'package:get/get.dart';

class ListLoanBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ListLoanController>(() => ListLoanController(),);
  }
}