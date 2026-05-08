import 'package:admin_dashboard/models/location_model.dart';
import 'package:admin_dashboard/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LocationController extends GetxController {

  final LocationService _service =
      LocationService();

  final locationTextController =
      TextEditingController();

  final locationList =
      <LocationModel>[].obs;

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  Future<void> getLocations() async {

    final data =
        await _service.getLocations();

    locationList.value = data;
  }

  void toggleLocationStatus(int index) {

    locationList[index].isActive =
        !locationList[index].isActive;

    locationList.refresh();
  }

  @override
  void onClose() {
    locationTextController.dispose();
    super.onClose();
  }
}