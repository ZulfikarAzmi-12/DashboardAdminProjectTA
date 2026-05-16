import 'package:admin_dashboard/binding/add_inventory_binding.dart';
import 'package:admin_dashboard/binding/category_binding.dart';
import 'package:admin_dashboard/binding/changepassword_binding.dart';
import 'package:admin_dashboard/binding/detail_inventory_binding.dart';
import 'package:admin_dashboard/binding/detail_loan_binding.dart';
import 'package:admin_dashboard/binding/home_binding.dart';
import 'package:admin_dashboard/binding/inventaris_binding.dart';
import 'package:admin_dashboard/binding/list_loan_binding.dart';
import 'package:admin_dashboard/binding/loan_binding.dart';
import 'package:admin_dashboard/binding/location_binding.dart';
import 'package:admin_dashboard/binding/manageuser_binding.dart';
import 'package:admin_dashboard/binding/navbar_binding.dart';
import 'package:admin_dashboard/binding/notification_binding.dart';
import 'package:admin_dashboard/binding/profile_binding.dart';
import 'package:admin_dashboard/binding/report_binding.dart';
import 'package:admin_dashboard/binding/splash_binding.dart';
import 'package:admin_dashboard/pages/add_inventory_page.dart';
import 'package:admin_dashboard/pages/add_user_page.dart';
import 'package:admin_dashboard/pages/category_page.dart';
import 'package:admin_dashboard/pages/change_password_page.dart';
import 'package:admin_dashboard/pages/detail_inventory_page.dart';
import 'package:admin_dashboard/pages/home_page.dart';
import 'package:admin_dashboard/pages/inventaris_page.dart';
import 'package:admin_dashboard/pages/laporan_page.dart';
import 'package:admin_dashboard/pages/list_loan_page.dart';
import 'package:admin_dashboard/pages/loan_detail_page.dart';
import 'package:admin_dashboard/pages/loan_form_page.dart';
import 'package:admin_dashboard/pages/location_page.dart';
import 'package:admin_dashboard/pages/login_page.dart';
import 'package:admin_dashboard/pages/main_page.dart';
import 'package:admin_dashboard/pages/manage_user_page.dart';
import 'package:admin_dashboard/pages/notification_page.dart';
import 'package:admin_dashboard/pages/splash_page.dart';
import 'package:admin_dashboard/pages/profile_page.dart';
import 'package:get/get.dart'; // Sesuaikan dengan nama file login kamu
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // Tambahkan baris ini agar route '/login' dikenali
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
      bindings: [
        NavbarBinding(),
        HomeBinding(),
        InventarisBinding(),
        ReportBinding(),
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.inventaris,
      page: () => InventarisPage(),
      binding: InventarisBinding(),
    ),
    GetPage(
      name: AppRoutes.laporan,
      page: () => ReportPage(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordPage(),
      binding: ChangepasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.manageUser,
      page: () => ManageuserPage(),
      binding: ManageuserBinding(),
    ),
    GetPage(
      name: AppRoutes.addUser,
      page: () => AddUserPage(),
      binding: ManageuserBinding(),
    ),
    GetPage(
      name: AppRoutes.addInventory,
      page: () => AddInventoryPage(),
      binding: AddInventoryBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.location,
      page: () => LocationPage(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.loan,
      page: () => LoanFormPage(),
      binding: LoanBinding(),
    ),
    GetPage(
      name: AppRoutes.listLoan,
      page: () => ListLoanPage(),
      binding: ListLoanBinding(),
    ),
    GetPage(
      name: AppRoutes.detailLoan,
      page: () => LoanDetailPage(),
      binding: DetailLoanBinding(),
    ),
    GetPage(
      name: AppRoutes.detailInventory,
      page: () => DetailInventoryPage(),
      binding: DetailInventoryBinding(),
    ),
  ];
}
