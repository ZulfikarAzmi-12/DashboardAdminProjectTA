import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/user_model.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final AccountService service = AccountService();

  Rxn<AccountModel> profile = Rxn<AccountModel>();

  final RxBool isLogoutLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final result = await service.getProfile();
      profile.value = result;
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

  Future<void> logout() async {
    if (isLogoutLoading.value) return;

    try {
      isLogoutLoading.value = true;

      // Supaya user sempat melihat loading
      await Future.delayed(const Duration(milliseconds: 800));

      final prefs = await SharedPreferences.getInstance();

      // Sesuaikan dengan key yang kamu gunakan saat login
      await prefs.remove("accesToken");
      await prefs.remove("role");

      Get.offAllNamed(AppRoutes.login);

      Get.snackbar(
        "Success",
        "Berhasil logout",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal logout",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLogoutLoading.value = false;
    }
  }
}
