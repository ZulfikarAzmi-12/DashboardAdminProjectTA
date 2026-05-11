import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/custom_fab.dart';
import 'package:admin_dashboard/components/card/user_card.dart';
import 'package:admin_dashboard/controller/manageuser_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../constants/app_color.dart';

class ManageuserPage extends StatelessWidget {
  ManageuserPage({super.key});

  final controller = Get.find<ManageUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Kelola User",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            /// LIST USER
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.users.isEmpty) {
                return const Center(child: Text("Data tidak ditemukan"));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];

                  return Slidable(
                    key: ValueKey(user.id),

                    /// ================= ACTION =================
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        /// DELETE
                        SlidableAction(
                          onPressed: (context) {
                            Get.dialog(
                              AlertDialog(
                                title: const Text("Hapus User"),
                                content: const Text(
                                  "Yakin ingin menghapus user ini?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.deleteUser(user.id);
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Hapus",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          backgroundColor: const Color(0xffEF4444),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    /// ================= CARD =================
                    child: UserCard(user: user),
                  );
                },
              );
            }),
          ],
        ),
      ),

      /// FAB
      floatingActionButton: CustomFAB(
        icon: Icons.add,
        onPressed: () {
          Get.toNamed(AppRoutes.addUser);
        },
      ),
    );
  }
}
