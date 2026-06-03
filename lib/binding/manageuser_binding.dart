import 'package:admin_dashboard/controller/manageuser_controller.dart';
import 'package:get/get.dart';

class ManageuserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ManageUserController>(() => ManageUserController(),);
  }
}