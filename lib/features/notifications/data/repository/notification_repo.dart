import '../model/notification_model.dart';
import 'notification_repo_interface.dart';

class NotificationRepo implements NotificationRepoInterface {
  final List<NotificationModel> mockNotifications = [
    NotificationModel(
      id: 'n1',
      title: 'Flash Sale: 50% Off Burgers!',
      message: 'Craving a burger? Use code BURGER50 to get 50% off on your signature truffle burger.',
      type: 'promo',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    NotificationModel(
      id: 'n2',
      title: 'Order Confirmed',
      message: 'Your order #10245 has been confirmed by The Burger Club.',
      type: 'order',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationModel(
      id: 'n3',
      title: 'Rider is arriving!',
      message: 'Your delivery rider is 500m away from your location.',
      type: 'delivery',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
    ),
  ];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return mockNotifications;
  }

  @override
  Future<bool> markAsRead(String id) async {
    final index = mockNotifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      final old = mockNotifications[index];
      mockNotifications[index] = NotificationModel(
        id: old.id,
        title: old.title,
        message: old.message,
        type: old.type,
        timestamp: old.timestamp,
        isRead: true,
      );
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteNotification(String id) async {
    mockNotifications.removeWhere((n) => n.id == id);
    return true;
  }
}
