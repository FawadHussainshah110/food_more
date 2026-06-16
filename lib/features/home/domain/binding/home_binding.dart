import 'package:get/get.dart';
import 'package:food_app_task/features/home/data/repository/home_repo_interface.dart';
import 'package:food_app_task/features/home/data/repository/home_repo.dart';
import 'package:food_app_task/features/home/domain/service/home_service_interface.dart';
import 'package:food_app_task/features/home/domain/service/home_service.dart';
import 'package:food_app_task/features/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // repository
    HomeRepoInterface homeRepo = HomeRepo();
    Get.lazyPut(() => homeRepo, fenix: true);

    // service
    HomeServiceInterface homeService = HomeService(homeRepo: Get.find());
    Get.lazyPut(() => homeService, fenix: true);

    // controller
    Get.lazyPut(() => HomeController(homeService: Get.find()), fenix: true);
  }
}
