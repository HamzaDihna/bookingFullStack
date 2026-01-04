import 'package:bookingresidentialapartments/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationsPage extends StatelessWidget {
  final controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchNotifications();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications'));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final n = controller.notifications[index];

            return ListTile(
              leading: Icon(
                Icons.notifications,
                color: n['is_read'] ? Colors.grey : Colors.blue,
              ),
              title: Text(
                n['title'],
                style: TextStyle(
                  fontWeight:
                      n['is_read'] ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Text(n['message']),
            );
          },
        );
      }),
    );
  }
}
