import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/login_button.dart';
import 'package:admin_dashboard/components/button/long_button.dart';
import 'package:admin_dashboard/components/button/profile_menu.dart';
import 'package:admin_dashboard/components/card/profile-card.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/profile_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

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
              // ── Bagian reactive (hanya profile data) ──────────────────
              Obx(() {
                final profile = controller.profile.value;

                if (profile == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileCard(name: profile.username, email: profile.email),

                    const SizedBox(height: 20),

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
                  ],
                );
              }),

              const Spacer(),

              
              Obx(
                () => LoginButton(
                  backgroundColor: AppColor.primary,
                  text: "Logout",
                  isLoading: controller.isLogoutLoading.value,
                  onPressed: controller.isLogoutLoading.value
                      ? null
                      : () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Peringatan"),
                              content: const Text("Apakah anda ingin logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back(); // tutup dialog

                                    controller.logout();
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
