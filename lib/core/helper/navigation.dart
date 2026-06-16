import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:food_app_task/core/widgets/confirmation_dialog.dart';

Future<dynamic> launchScreen(Widget child, {bool pushAndRemove = false, bool replace = false}) async {
  const Duration duration = Duration(milliseconds: 500);
  if (pushAndRemove) {
    return Get.offAll(() => child, duration: duration, transition: Transition.cupertino, routeName: routeName(child));
  } else if (replace) {
    return Get.off(() => child, duration: duration, transition: Transition.cupertino, routeName: routeName(child));
  } else {
    return Get.to(() => child, duration: duration, transition: Transition.cupertino, routeName: routeName(child));
  }
}

Future<void> exitApp() async {
  await showConfirmationDialog(
    title: 'exit_app'.tr,
    subtitle: 'exit_confirmation'.tr,
    cancelText: 'no_stay'.tr,
    actionText: 'yes_exit'.tr,
    onAccept: () => SystemNavigator.pop(),
  );
}

// Convert widget to route name
String routeName(Widget widget) {
  // Get the class name of the widget as a string
  String className = widget.runtimeType.toString();
  // Remove "Screen" or other suffixes if needed
  if (className.endsWith('Screen')) {
    className = className.replaceAll('Screen', '');
  }
  // Convert to lowercase for route name
  String route = className.toLowerCase();
  return route;
}

void pop() => Get.back();
