import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 5));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accesToken");

    if (token == null || token.isEmpty) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
