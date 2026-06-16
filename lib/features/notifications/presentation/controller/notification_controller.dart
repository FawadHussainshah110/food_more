import 'package:get/get.dart';
import 'package:food_app_task/features/notifications/data/model/notification_model.dart';
import 'package:food_app_task/features/notifications/domain/service/notification_service_interface.dart';

class NotificationController extends GetxController {
  final NotificationServiceInterface notificationService;

  NotificationController({required this.notificationService}) {
    loadNotifications();
  }

  bool isLoading = false;
  final List<NotificationModel> notifications = [];

  void loadNotifications() async {
    isLoading = true;
    update();
    try {
      final list = await notificationService.getNotifications();
      notifications.clear();
      notifications.addAll(list);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      update();
    }
  }

  void markNotificationAsRead(String id) async {
    final success = await notificationService.markAsRead(id);
    if (success) {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index >= 0) {
        final old = notifications[index];
        notifications[index] = NotificationModel(
          id: old.id,
          title: old.title,
          message: old.message,
          type: old.type,
          timestamp: old.timestamp,
          isRead: true
        );
        update();
      }
    }
  }

  void deleteNotificationItem(String id) async {
    final success = await notificationService.deleteNotification(id);
    if (success) {
      notifications.removeWhere((n) => n.id == id);
      update();
    }
  }

  static NotificationController get find => Get.find<NotificationController>();
}
