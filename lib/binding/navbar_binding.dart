import 'package:admin_dashboard/controller/navbar_controller.dart';
import 'package:get/get.dart';

class NavbarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
  }
}