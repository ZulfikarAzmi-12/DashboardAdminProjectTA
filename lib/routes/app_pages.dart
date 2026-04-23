import 'package:admin_dashboard/binding/home_binding.dart';
import 'package:admin_dashboard/binding/inventaris_binding.dart';
import 'package:admin_dashboard/binding/navbar_binding.dart';
import 'package:admin_dashboard/binding/report_binding.dart';
import 'package:admin_dashboard/pages/home_page.dart';
import 'package:admin_dashboard/pages/inventaris_page.dart';
import 'package:admin_dashboard/pages/laporan_page.dart';
import 'package:admin_dashboard/pages/login_page.dart';
import 'package:admin_dashboard/pages/main_page.dart';
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
      HomeBinding(),
      InventarisBinding(),
      ReportBinding()
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
    binding: InventarisBinding()
    ),
    GetPage(
    name: AppRoutes.laporan,
    page: () => ReportPage(),
    binding: ReportBinding()  
    ),
    GetPage(
    name: AppRoutes.userList,
    page: () => UserlistPage(),
    ),
  ];
}