import 'package:food_app_task/features/notifications/data/model/notification_model.dart';
import 'package:food_app_task/features/notifications/data/repository/notification_repo_interface.dart';
import 'notification_service_interface.dart';

class NotificationService implements NotificationServiceInterface {
  final NotificationRepoInterface notificationRepo;

  NotificationService({required this.notificationRepo});

  @override
  Future<List<NotificationModel>> getNotifications() {
    return notificationRepo.getNotifications();
  }

  @override
  Future<bool> markAsRead(String id) {
    return notificationRepo.markAsRead(id);
  }

  @override
  Future<bool> deleteNotification(String id) {
    return notificationRepo.deleteNotification(id);
  }
}
