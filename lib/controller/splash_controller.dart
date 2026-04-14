import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    // Tunggu selama 3 detik
    await Future.delayed(const Duration(seconds: 3));
    
    // Pindah ke halaman login dan hapus splash dari history (agar tidak bisa back)
    Get.offAllNamed(AppRoutes.login);
  }
}