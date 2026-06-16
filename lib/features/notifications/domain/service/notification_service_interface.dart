import '../../data/model/notification_model.dart';

abstract class NotificationServiceInterface {
  Future<List<NotificationModel>> getNotifications();
  Future<bool> markAsRead(String id);
  Future<bool> deleteNotification(String id);
}
