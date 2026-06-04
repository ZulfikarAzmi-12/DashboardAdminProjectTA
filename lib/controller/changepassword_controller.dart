import 'package:admin_dashboard/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_dashboard/models/error_model.dart';

class ChangePasswordController extends GetxController {
  final AuthService _service = AuthService();

  /// ================= STATE =================
  var isLoading = false.obs;
  var isError = false.obs;

  /// ================= CONTROLLER =================
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  /// ================= CHANGE PASSWORD =================
  Future<void> changePassword() async {
    try {
      isLoading.value = true;
      isError.value = false;

      if (oldPasswordController.text.trim().isEmpty ||
          newPasswordController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Semua field harus diisi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFFA726),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
        );
        return;
      }

      await _service.changePassword(
        passwordLama: oldPasswordController.text.trim(),
        passwordBaru: newPasswordController.text.trim(),
      );

      oldPasswordController.clear();
      newPasswordController.clear();

      Get.back();

      Get.snackbar(
        "Sukses",
        "Password berhasil diubah",
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
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
