import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:admin_dashboard/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final LocationService service = LocationService();
  final InventarisService inventarisService = InventarisService();

  final locationTextController = TextEditingController();

  var locationList = <LocationModel>[].obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  Future<void> getLocations() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await inventarisService.getLocations();

      locationList.value = result;
    } on AppError catch (e) {
      isError.value = true;

      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      errorMessage.value = message;

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      isError.value = true;

      errorMessage.value = "Terjadi kesalahan";

      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }

    isLoading.value = false;
  }

  void toggleLocationStatus(int index) {
    final item = locationList[index];

    locationList[index] = LocationModel(
      id: item.id,
      locationName: item.locationName,
      isActive: item.isActive,
    );
  }

  Future<void> createLocation() async {
    try {
      final locationName = locationTextController.text.trim();

      if (locationName.isEmpty) {
        Get.snackbar(
          "Error",
          "Nama lokasi wajib diisi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFFA726),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
        );

        return;
      }

      final result = await service.createLocation(locationName);

      locationList.insert(0, result);

      locationTextController.clear();

      Get.snackbar(
        "Success",
        "Berhasil menambahkan lokasi",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  Future<void> updateLocation({
    required String locationId,
    String? locationName,
    bool? isActive,
  }) async {
    try {
      final result = await service.updateLocation(
        locationId: locationId,
        locationName: locationName,
        isActive: isActive,
      );

      final index = locationList.indexWhere((e) => e.id == locationId);

      if (index != -1) {
        locationList[index] = result;
        locationList.refresh();
      }

      Get.snackbar(
        "Success",
        "Berhasil update lokasi",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      String message = e.message;

      if (e.errors != null && e.errors!.isNotEmpty) {
        message = e.errors![0]["message"];
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  @override
  void onClose() {
    locationTextController.dispose();
    super.onClose();
  }
}
