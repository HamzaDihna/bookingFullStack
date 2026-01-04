import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <dynamic>[].obs;
  var unreadCount = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUnreadCount();
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    notifications.value = await ApiService.get('notifications');
    isLoading.value = false;
  }

  Future<void> fetchUnreadCount() async {
    final res = await ApiService.get('notifications/unread-count');
    unreadCount.value = res['count'];
  }

  Future<void> markAllAsRead() async {
    await ApiService.post('notifications/mark-all-read');
    unreadCount.value = 0;

    for (var n in notifications) {
      n['is_read'] = true;
    }
    notifications.refresh();
  }
}
