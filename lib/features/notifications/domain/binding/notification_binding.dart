import 'package:get/get.dart';
import 'package:food_app_task/features/notifications/data/repository/notification_repo_interface.dart';
import 'package:food_app_task/features/notifications/data/repository/notification_repo.dart';
import 'package:food_app_task/features/notifications/domain/service/notification_service_interface.dart';
import 'package:food_app_task/features/notifications/domain/service/notification_service.dart';
import 'package:food_app_task/features/notifications/presentation/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // repository
    NotificationRepoInterface notificationRepo = NotificationRepo();
    Get.lazyPut(() => notificationRepo, fenix: true);

    // service
    NotificationServiceInterface notificationService = NotificationService(notificationRepo: Get.find());
    Get.lazyPut(() => notificationService, fenix: true);

    // controller
    Get.lazyPut(() => NotificationController(notificationService: Get.find()), fenix: true);
  }
}
