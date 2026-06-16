import 'package:food_app_task/features/orders/presentation/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController(), fenix: true);
  }
}
