import 'package:admin_dashboard/components/navbar/reusable_navbar.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/navbar_controller.dart';
import 'package:admin_dashboard/pages/home_page.dart';
import 'package:admin_dashboard/pages/inventaris_page.dart';
import 'package:admin_dashboard/pages/laporan_page.dart';
import 'package:admin_dashboard/pages/userlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final navbarController = Get.find<NavbarController>();

  MainPage({super.key});

  final pages = [
    HomePage(),
    InventarisPage(),
    ReportPage(),
    UserlistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() => pages[navbarController.selectedIndex.value]),
      bottomNavigationBar: ReusableNavbar(),
    );
  }
}