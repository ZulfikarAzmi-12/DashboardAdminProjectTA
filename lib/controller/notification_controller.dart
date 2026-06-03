import 'package:admin_dashboard/models/error_model.dart';
import 'package:get/get.dart';

import '../models/notif_model.dart';
import '../services/notif_service.dart';

class NotifController extends GetxController {
  final _notifService = NotifService();

  final RxList<NotifModel> daftarNotif = <NotifModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _notifService.getNotifications();
      daftarNotif.assignAll(result);
    } on AppError catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat memuat notifikasi';
    } finally {
      isLoading.value = false;
    }
  }
}
