import 'package:admin_dashboard/models/loan_model.dart';
import 'package:admin_dashboard/services/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeService service = HomeService();

  /// 🔥 STATE
  var loans = <LoanModel>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchLoans();
    super.onInit();
  }

  /// 🔥 FETCH DATA (siap API)
  void fetchLoans() async {
    isLoading.value = true;
    isError.value = false;

    try {
      final result = await service.fetchLoans();
      loans.value = result;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }
}
