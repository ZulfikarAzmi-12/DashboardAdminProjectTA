import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/card/notification_card.dart';
import 'package:admin_dashboard/controller/notification_controller.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifPage extends StatelessWidget {
  NotifPage({super.key});

  final controller = Get.find<NotifController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(
        title: "",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Get.previousRoute.isEmpty) {
              Get.offAllNamed(AppRoutes.main);
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Obx(() {
        // State: Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE53935)),
          );
        }

        // State: Error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFFE53935),
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchNotifications,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Coba Lagi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        // State: Empty
        if (controller.daftarNotif.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off_outlined,
                  size: 48,
                  color: Color(0xFFBDBDBD),
                ),
                SizedBox(height: 12),
                Text(
                  'Belum ada notifikasi',
                  style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          );
        }

        // State: Data tersedia
        return RefreshIndicator(
          color: const Color(0xFFE53935),
          onRefresh: controller.fetchNotifications,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: controller.daftarNotif.length,
            itemBuilder: (context, index) {
              final notif = controller.daftarNotif[index];
              return NotifCard(
                notif: notif,
                onTap: () => controller.markAsRead(notif.id),
              );
            },
          ),
        );
      }),
    );
  }
}
