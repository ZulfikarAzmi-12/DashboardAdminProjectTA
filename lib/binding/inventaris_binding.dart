import 'package:admin_dashboard/controller/inventaris_controller.dart';
import 'package:get/get.dart';

class InventarisBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InventarisController>(() => InventarisController());
  }
}