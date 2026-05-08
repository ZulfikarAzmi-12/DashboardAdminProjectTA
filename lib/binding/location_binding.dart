import 'package:admin_dashboard/controller/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LocationController>(() => LocationController(),);
  }
  
}