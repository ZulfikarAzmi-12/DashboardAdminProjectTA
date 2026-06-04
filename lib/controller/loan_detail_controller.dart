import 'package:admin_dashboard/models/detail_loan_model.dart';
import 'package:admin_dashboard/models/error_model.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:admin_dashboard/services/detail_loan_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanDetailController extends GetxController {
  final LoanDetailService _loanService = LoanDetailService();

  // ── Observable state ──────────────────────────────────────────────────────
  final isLoading = false.obs;
  final isActionLoading = false.obs;
  final Rx<LoanDetailModel?> loanDetail = Rx<LoanDetailModel?>(null);

  Rx<LoanDetailModel?> get loanData => loanDetail;

  late String _loanId;

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loanId = Get.arguments as String;
    fetchLoanDetail(_loanId);
  }

  // ── Fetch detail ──────────────────────────────────────────────────────────
  void fetchLoanDetail(String loanId) async {
    try {
      isLoading.value = true;
      final result = await _loanService.getLoanDetail(loanId);
      print(result);
      loanDetail.value = result;
    } on AppError catch (e) {
      _showError("Gagal Memuat Data", e);
    } catch (e) {
      _showGenericError();
    } finally {
      isLoading.value = false;
    }
  }

  // ── Accept ────────────────────────────────────────────────────────────────
  void approveLoan() async {
    try {
      isActionLoading.value = true;
      final message = await _loanService.acceptLoan(_loanId);
      Get.back(result: true);
      Get.snackbar(
        "Berhasil",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      _showError("Gagal Menyetujui", e);
    } catch (e) {
      _showGenericError();
    } finally {
      isActionLoading.value = false;
    }
  }

  // ── Reject — tampilkan dialog input alasan dulu ───────────────────────────
  void rejectLoan() {
    final reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Tolak Peminjaman",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Masukkan alasan penolakan:",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Contoh: Stok tidak tersedia...",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF8B2323)),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        actions: [
          // Batal
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          // Konfirmasi tolak
          Obx(
            () => ElevatedButton(
              onPressed: isActionLoading.value
                  ? null
                  : () async {
                      final reason = reasonController.text.trim();
                      if (reason.isEmpty) {
                        Get.snackbar(
                          "Perhatian",
                          "Alasan penolakan tidak boleh kosong",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: const Color(0xFFFFA726),
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 8,
                        );
                        return;
                      }
                      await _doRejectLoan(reason);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B2323),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isActionLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Tolak", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _doRejectLoan(String reason) async {
    try {
      isActionLoading.value = true;
      final message = await _loanService.rejectLoan(_loanId, reason);
      Get.back(); // tutup dialog
      Get.back(result: true); // balik ke list
      Get.snackbar(
        "Berhasil",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFFFA726),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      _showError("Gagal Menolak", e);
    } catch (e) {
      _showGenericError();
    } finally {
      isActionLoading.value = false;
    }
  }

  // ── Return ────────────────────────────────────────────────────────────────
  void returnLoan() async {
    try {
      isActionLoading.value = true;
      final message = await _loanService.returnLoan(_loanId);
      Get.offAllNamed(AppRoutes.main);
      Get.snackbar(
        "Berhasil",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF66BB6A),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    } on AppError catch (e) {
      _showError("Gagal Mencatat Pengembalian", e);
    } catch (e) {
      _showGenericError();
    } finally {
      isActionLoading.value = false;
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void _showError(String title, AppError e) {
    String message = e.message;
    if (e.errors != null && e.errors!.isNotEmpty) {
      message = e.errors![0]["message"] as String;
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFE57373),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }

  void _showGenericError() {
    Get.snackbar(
      "Error",
      "Terjadi kesalahan, coba lagi nanti",
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFE57373),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}
