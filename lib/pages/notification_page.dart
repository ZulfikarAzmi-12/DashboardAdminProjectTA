import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/card/notification_card.dart';
import 'package:admin_dashboard/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(
        title: "Notification",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) {

          final item = controller.notifications[index];

          return NotificationCard(
            title: item["title"]!,
            description: item["description"]!,
          );
        },
      ),
    );
  }
}