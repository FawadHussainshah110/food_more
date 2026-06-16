import 'package:flutter/services.dart';
import 'package:food_app_task/imports.dart';
import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String formatDate() {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
  }

  String toMonthYear() {
    return DateFormat('MMMM yyyy').format(this);
  }

  String toFullDate() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String toShortDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String toDayMonth() {
    return DateFormat('dd MMMM').format(this);
  }

  String toTime() {
    return DateFormat('HH:mm').format(this);
  }

  String toDateWithTime() {
    return DateFormat('dd MMM yyyy, HH:mm').format(this);
  }

  String toDayName() {
    return DateFormat('E').format(this);
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isToday() {
    final now = DateTime.now();
    return isSameDay(now);
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return 'today'.tr;
    } else if (difference.inDays == 1) {
      return 'yesterday'.tr;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${'days_ago'.tr}';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week_ago'.tr : 'weeks_ago'.tr}';
    } else {
      return DateFormat('MMM d, yyyy').format(this);
    }
  }
}

extension DateTimeExtension on String {
  String formatDate() {
    try {
      final dateTime = DateTime.parse(this);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return this;
    }
  }

  /// Formats a datetime string to a readable format
  /// Example: "January 25, 2025 at 2:30 PM"
  String formatDateTime() {
    try {
      final DateTime dateTime = DateTime.parse(this);
      final String formattedDate = "${dateTime.monthName} ${dateTime.day}, ${dateTime.year}";
      final String formattedTime =
          "${dateTime.hour12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.period}";
      return "$formattedDate at $formattedTime";
    } catch (e) {
      return this;
    }
  }

  /// Formats a datetime string to date only with full month name
  /// Example: "January 25, 2025"
  String formatFullDate() {
    try {
      final DateTime dateTime = DateTime.parse(this);
      return "${dateTime.monthName} ${dateTime.day}, ${dateTime.year}";
    } catch (e) {
      return this;
    }
  }

  /// Formats a datetime string to time only
  /// Example: "2:30 PM"
  String formatTime() {
    try {
      final DateTime dateTime = DateTime.parse(this);
      return "${dateTime.hour12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.period}";
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeHelpers on DateTime {
  /// Gets the month name
  String get monthName {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  /// Gets 12-hour format hour
  int get hour12 {
    if (hour == 0) return 12;
    if (hour > 12) return hour - 12;
    return hour;
  }

  /// Gets AM/PM period
  String get period => hour >= 12 ? 'PM' : 'AM';
}

extension ExpiryDateFormatter on List<TextInputFormatter> {
  static List<TextInputFormatter> buildExpiryDateFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      TextInputFormatter.withFunction((oldValue, newValue) {
        String text = newValue.text.replaceAll('/', '');

        if (text.length > 8) {
          return oldValue;
        }

        StringBuffer buffer = StringBuffer();

        for (int i = 0; i < text.length; i++) {
          buffer.write(text[i]);
          if ((i == 1 || i == 3) && i != text.length - 1) {
            buffer.write('/');
          }
        }

        final formatted = buffer.toString();

        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }),
    ];
  }
}

enum BookingType {
  active,
  completed,
  pending,
  cancelled,
  rejected;

  String get label {
    return name.tr;
  }

  IconData get icon {
    switch (this) {
      case BookingType.active:
        return Icons.event_available;
      case BookingType.pending:
        return Icons.pending_actions;
      case BookingType.completed:
        return Icons.history;
      case BookingType.cancelled:
      case BookingType.rejected:
        return Icons.cancel;
    }
  }
}

extension BookingHistoryTypeExtension on BookingType {
  Color getStatusColor(BuildContext context) {
    switch (this) {
      case BookingType.active:
        return primaryColor;
      case BookingType.completed:
        return context.theme.colorScheme.inversePrimary;
      case BookingType.pending:
        return Colors.orange;
      case BookingType.cancelled:
        return context.theme.colorScheme.error;
      case BookingType.rejected:
        return context.theme.disabledColor;
    }
  }
}

extension OrderStatusExtension on String {
  String get statusText {
    switch (this) {
      case "new_booking":
        return "new_booking".tr;
      case "pending":
        return "pending".tr;
      case "accepted":
        return "accepted".tr;
      case "in_progress":
        return "in_progress".tr;
      case "completed":
        return "completed".tr;
      case "canceled":
        return "cancelled".tr;
      case "pending_acceptance":
        return "pending_acceptance".tr;
      case "order_accepted":
        return "order_accepted".tr;
      case "order_in_progress":
        return "order_in_progress".tr;
      case "order_completed":
        return "order_completed".tr;
      case "order_cancelled":
        return "order_cancelled".tr;
      default:
        return "unknown".tr;
    }
  }

  Color statusColor(BuildContext context) {
    switch (this) {
      case "new_booking":
      case "booked":
      case "pending":
      case "pending_acceptance":
        return Colors.orange;
      case "accepted":
      case "processing":
      case "arriving":
      case "arrived":
      case "order_accepted":
        return Colors.blue;
      case "in_progress":
      case "order_in_progress":
        return Colors.purple;
      case "completed":
      case "order_completed":
        return Colors.green;
      case "canceled":
      case "cancelled":
      case "order_cancelled":
        return Colors.red;
      case "active":
        return Colors.green;
      case "inactive":
        return Colors.orange;
      case "draft":
        return Colors.grey;
      default:
        return Theme.of(context).hintColor;
    }
  }
}
