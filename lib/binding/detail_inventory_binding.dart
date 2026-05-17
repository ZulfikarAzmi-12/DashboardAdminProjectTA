import 'package:admin_dashboard/controller/detail_inventory_controller.dart';
import 'package:get/get.dart';

class DetailInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailInventoryController>(() => DetailInventoryController());
  }
}
