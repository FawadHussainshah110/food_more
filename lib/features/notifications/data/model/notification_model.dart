class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'promo', 'order', 'delivery', 'payment'
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
  });
}
