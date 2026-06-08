import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/login_button.dart';
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
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Icon
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.logout_rounded,
                                        color: Colors.red.shade400,
                                        size: 32,
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    // Title
                                    const Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Subtitle
                                    const Text(
                                      "Apakah anda yakin ingin keluar\ndari aplikasi ini?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black45,
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // Divider
                                    const Divider(
                                      height: 1,
                                      color: Color(0xffF0F0F0),
                                    ),

                                    const SizedBox(height: 16),

                                    // Buttons
                                    Row(
                                      children: [
                                        // Batal
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () => Get.back(),
                                            style: OutlinedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              side: const BorderSide(
                                                color: Color(0xffE0E0E0),
                                              ),
                                            ),
                                            child: const Text(
                                              "Batal",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        // Logout
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              controller.logout();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                              backgroundColor:
                                                  Colors.red.shade400,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              "Logout",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            barrierDismissible: true,
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
