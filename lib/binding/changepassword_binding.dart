import 'package:admin_dashboard/controller/changepassword_controller.dart';
import 'package:get/get.dart';

class ChangepasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
