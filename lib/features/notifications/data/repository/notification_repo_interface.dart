import '../model/notification_model.dart';

abstract class NotificationRepoInterface {
  Future<List<NotificationModel>> getNotifications();
  Future<bool> markAsRead(String id);
  Future<bool> deleteNotification(String id);
}
