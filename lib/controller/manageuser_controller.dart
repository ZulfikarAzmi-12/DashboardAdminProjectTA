import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_dashboard/models/user_model.dart';
import 'package:admin_dashboard/services/user_service.dart';

class ManageUserController extends GetxController {
  final UserService _service = UserService();

  /// ================= STATE =================
  var isLoading = true.obs;
  var users = <UserModel>[].obs;

  /// ================= FORM STATE =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedRole = "".obs;

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// ================= FETCH =================
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;

      final result = await _service.getUsers();
      users.value = result;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= ADD USER =================
  void addUser() {
    if (!_validateForm()) return;

    final newUser = UserModel(
      id: users.length + 1,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      role: selectedRole.value,
    );

    users.add(newUser);

    resetForm();

    Get.back(); // kembali ke page sebelumnya
    Get.snackbar("Sukses", "User berhasil ditambahkan");
  }

  /// ================= VALIDATION =================
  bool _validateForm() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedRole.value.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi");
      return false;
    }
    return true;
  }

  /// ================= RESET FORM =================
  void resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedRole.value = "";
  }

  /// ================= CLEANUP =================
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}