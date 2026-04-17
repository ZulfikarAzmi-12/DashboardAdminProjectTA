import 'package:admin_dashboard/binding/home_binding.dart';
import 'package:admin_dashboard/binding/navbar_binding.dart';
import 'package:admin_dashboard/pages/home_page.dart';
import 'package:admin_dashboard/pages/inventaris_page.dart';
import 'package:admin_dashboard/pages/laporan_page.dart';
import 'package:admin_dashboard/pages/login_page.dart';
import 'package:admin_dashboard/pages/main_pages.dart';
import 'package:admin_dashboard/pages/splash_page.dart';
import 'package:admin_dashboard/pages/userlist_page.dart';
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
    name: AppRoutes.main,
    page: () => MainPage(),
    bindings: [
      NavbarBinding(),
      HomeBinding()
    ]
    ),
    GetPage(
    name: AppRoutes.home,
    page: () => HomePage(),
    binding: HomeBinding()
    ),
    GetPage(
    name: AppRoutes.inventaris,
    page: () => InventarisPage(),
    ),
    GetPage(
    name: AppRoutes.laporan,
    page: () => LaporanPage(),
    ),
    GetPage(
    name: AppRoutes.userList,
    page: () => UserlistPage(),
    ),
  ];
}