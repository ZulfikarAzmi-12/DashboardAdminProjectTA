import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/button/profile_menu.dart';
import 'package:admin_dashboard/components/card/profile-card.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Profile",
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColor.primary),
            onPressed: () {
              Get.toNamed(AppRoutes.notification);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE CARD
              const ProfileCard(
                name: "Surya Setiadi",
                email: "suryasetiadi@gmail.com",
              ),

              const SizedBox(height: 20),

              // MENU
              MenuTile(
                title: "Ganti Password",
                icon: Icons.lock,
                onTap: () {
                  Get.toNamed(AppRoutes.changePassword);
                },
              ),

              MenuTile(
                title: "Kelola User",
                icon: Icons.person,
                onTap: () {
                  Get.toNamed(AppRoutes.manageUser);
                },
              ),

              const Spacer(),

              // LOGOUT BUTTON
              BigButton(
                title: "Logout",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}