import 'package:get/get.dart';
import 'package:food_app_task/features/dashboard/presentation/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(), fenix: true);
  }
}
