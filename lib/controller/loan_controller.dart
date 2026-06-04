import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/models/user_model.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/loan_service.dart';
import 'package:admin_dashboard/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BorrowerOption {
  final String id;
  final String name;

  BorrowerOption({required this.id, required this.name});
}

class LoanController extends GetxController {
  // ─── Services ────────────────────────────────────────────────────
  final _unitService = LoanService();
  final _accountService = AccountService();

  // ─── Text Controllers ─────────────────────────────────────────────
  final purposeC = TextEditingController();

  // ─── Unit ─────────────────────────────────────────────────────────
  String unitId = '';

  // ─── Tanggal ──────────────────────────────────────────────────────
  final tglPeminjaman = Rxn<DateTime>();
  final tglPengembalian = Rxn<DateTime>();

  // ─── Schedule ─────────────────────────────────────────────────────
  final schedules = <ScheduleModel>[].obs;
  final isLoadingSchedule = false.obs;

  // ─── Borrower (Accounts) ──────────────────────────────────────────
  final _accounts = <AccountModel>[].obs;

  List<BorrowerOption> get borrowerOptions =>
      _accounts.map((a) => BorrowerOption(id: a.id, name: a.username)).toList();

  final selectedBorrower = ''.obs;

  // ─── Loading Borrow ───────────────────────────────────────────────
  final isLoadingBorrow = false.obs;

  // ─────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    unitId = Get.arguments as String? ?? '';
    _loadInitialData();
  }

  void _loadInitialData() {
    _fetchSchedules();
    _fetchAccounts();
  }

  // ─── Fetch Schedules ──────────────────────────────────────────────
  Future<void> _fetchSchedules() async {
    if (unitId.isEmpty) return;

    try {
      isLoadingSchedule(true);
      final result = await _unitService.getUnitSchedule(unitId);
      schedules.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Gagal',
        e is AppError ? e.message : 'Gagal mengambil jadwal',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoadingSchedule(false);
    }
  }

  // ─── Fetch Accounts ───────────────────────────────────────────────
  Future<void> _fetchAccounts() async {
    try {
      final result = await _accountService.getAccounts();
      _accounts.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Gagal',
        e is AppError ? e.message : 'Gagal mengambil daftar peminjam',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  // ─── Borrow Unit ──────────────────────────────────────────────────
  Future<void> borrowUnit() async {
    if (tglPeminjaman.value == null ||
        tglPengembalian.value == null ||
        purposeC.text.isEmpty ||
        selectedBorrower.value.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Semua field wajib diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFFFA726),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
      return;
    }

    String toIso(DateTime dt) => "${dt.toIso8601String().substring(0, 19)}.000";

    try {
      isLoadingBorrow(true);

      await _unitService.borrowUnit(
        unitId: unitId,
        userId: selectedBorrower.value,
        purpose: purposeC.text.trim(),
        borrowedDate: toIso(tglPeminjaman.value!),
        returnDate: toIso(tglPengembalian.value!),
      );

      Get.snackbar(
        'Berhasil',
        'Peminjaman berhasil dicatat',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );

      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      Get.snackbar(
        'Gagal',
        e is AppError ? e.message : 'Gagal meminjam unit',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } finally {
      isLoadingBorrow(false);
    }
  }

  @override
  void onClose() {
    purposeC.dispose();
    super.onClose();
  }
}
