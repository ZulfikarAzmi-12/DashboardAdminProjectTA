import 'package:admin_dashboard/pages/home_page.dart';
import 'package:admin_dashboard/pages/login_page.dart';
import 'package:admin_dashboard/pages/splash_page.dart';
import 'package:get/get.dart'; // Sesuaikan dengan nama file login kamu
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // Tambahkan baris ini agar route '/login' dikenali
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
    name: AppRoutes.splash,
    page: () => SplashPage(),
    ),
    GetPage(
    name: AppRoutes.home,
    page: () => HomePage(),
    ),
  ];
}