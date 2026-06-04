import 'package:admin_dashboard/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/services/user_service.dart';

class ManageUserController extends GetxController {
  final AccountService _service = AccountService();

  /// ================= STATE =================
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var users = <AccountModel>[].obs;

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// ================= FORM =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  var selectedRole = ''.obs;

  /// ================= CLEAR FORM =================
  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedRole.value = '';
  }

  /// ================= FETCH USERS =================
  Future<void> fetchUsers() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await _service.getAccounts();

      users.value = result;
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
      debugPrint("FETCH USERS ERROR: $e");

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
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= CREATE USER =================
  Future<void> createUser() async {
    try {
      isLoading.value = true;
      isError.value = false;

      if (nameController.text.trim().isEmpty ||
          emailController.text.trim().isEmpty ||
          phoneController.text.trim().isEmpty ||
          selectedRole.value.isEmpty) {
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

      await _service.createUser(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        role: selectedRole.value,
      );

      // Bersihkan form
      clearForm();

      // Tutup dialog/page
      Get.back();

      // Refresh data
      await fetchUsers();

      Get.snackbar(
        "Sukses",
        "User berhasil ditambahkan",
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
      debugPrint("CREATE USER ERROR: $e");

      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= DELETE USER =================
  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;
      isError.value = false;

      await _service.deleteUser(userId);

      users.removeWhere((e) => e.id == userId);

      Get.snackbar(
        "Sukses",
        "User berhasil dihapus",
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
      debugPrint("DELETE USER ERROR: $e");

      Get.snackbar(
        "Error",
        "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= DISPOSE =================
  @override
  void onClose() {
    clearForm();

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.onClose();
  }
}
