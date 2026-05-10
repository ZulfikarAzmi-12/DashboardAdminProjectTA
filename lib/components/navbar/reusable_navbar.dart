import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableNavbar extends StatelessWidget {
  final navbarController =Get.find<NavbarController>();

  ReusableNavbar({super.key});

  Widget buildItem(IconData icon, int index) {
    return Obx(() {
      final isActive = navbarController.selectedIndex.value == index;

      return GestureDetector(
        onTap: () => navbarController.changeIndex(index),
        child: Icon(
          icon,
          color: isActive ? AppColor.primary : AppColor.gray,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildItem(Icons.home, 0),
          buildItem(Icons.inventory, 1),
          buildItem(Icons.build, 2),
          buildItem(Icons.person, 3),
        ],
      ),
    );
  }
}