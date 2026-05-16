import 'package:admin_dashboard/models/detail_loan_model.dart';
import 'package:admin_dashboard/services/detail_loan_service.dart';
import 'package:get/get.dart';

class LoanDetailController extends GetxController {
  final LoanDetailService _service = LoanDetailService();

  final Rx<LoanDetailModel> loanData = LoanDetailModel(
    status: '',
    loanCode: '',
    borrowDate: '',
    returnDate: '',
    itemName: '',
    itemCode: '',
    borrowerName: '',
    borrowerPhone: '',
    loanPurpose: '',
    imageUrl: '',
  ).obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoanDetail();
  }

  Future<void> loadLoanDetail() async {
    try {
      isLoading.value = true;

      final response = await _service.getLoanDetail();

      loanData.value = response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveLoan() async {
    try {
      /// TODO:
      /// Integrasi API approve loan

      Get.snackbar('Success', 'Peminjaman disetujui');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> rejectLoan() async {
    try {
      /// TODO:
      /// Integrasi API reject loan

      Get.snackbar('Success', 'Peminjaman ditolak');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
