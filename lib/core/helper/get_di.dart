import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_task/core/utils/app_constants.dart';
import 'package:food_app_task/features/theme/domain/binding/theme_binding.dart';
import 'package:food_app_task/features/auth/domain/binding/auth_binding.dart';
import 'package:food_app_task/features/cart/domain/binding/cart_binding.dart';
import 'package:food_app_task/features/wishlist/domain/binding/wishlist_binding.dart';
import 'package:food_app_task/features/dashboard/domain/binding/dashboard_binding.dart';
import 'package:food_app_task/features/home/domain/binding/home_binding.dart';
import 'package:food_app_task/features/notifications/domain/binding/notification_binding.dart';
import 'package:food_app_task/features/orders/domain/binding/order_binding.dart';
import 'package:food_app_task/features/payment/domain/binding/payment_binding.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_client_interface.dart';

Future<void> init() async {
  const secureStorage = FlutterSecureStorage();
  Get.lazyPut(() => secureStorage);
  ApiClientInterface apiClient = ApiClient(storage: Get.find(), baseUrl: AppConstants.baseUrl);
  Get.lazyPut(() => apiClient);

  List<Bindings> bindings = [
    ThemeBinding(),
    AuthBinding(),
    CartBinding(),
    WishlistBinding(),
    DashboardBinding(),
    HomeBinding(),
    NotificationBinding(),
    PaymentBinding(),
    OrderBinding(),
  ];

  for (Bindings binding in bindings) {
    binding.dependencies();
  }
}
