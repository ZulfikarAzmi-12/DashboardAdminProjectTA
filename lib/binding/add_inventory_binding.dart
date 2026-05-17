import 'package:admin_dashboard/controller/add_inventory_controller.dart';
import 'package:get/get.dart';

class AddInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInventoryController>(() => AddInventoryController());
  }
}
