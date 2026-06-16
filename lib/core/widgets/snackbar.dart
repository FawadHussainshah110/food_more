import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

showLoading() {
  try {
    SmartDialog.showLoading();
  } catch (e) {
    // Silently catch overlay errors
  }
}

hideLoading() {
  try {
    SmartDialog.dismiss(status: SmartStatus.loading);
  } catch (e) {
    // Silently catch overlay errors when already disposed
  }
}

showToast(String text) {
  try {
    // Don't dismiss existing toasts - let them queue naturally
    // This prevents the overlay disposal error
    SmartDialog.showToast(
      text,
      displayTime: const Duration(seconds: 3),
      builder:
          (context) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Text(
              text,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
    );
  } catch (e) {}
}

showCustomSnackBar(String text, {bool isError = false}) {
  showToast(text);
}
