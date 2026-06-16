import 'package:food_app_task/features/auth/data/repository/auth_repo.dart';
import 'package:food_app_task/features/auth/data/repository/auth_repo_interface.dart';
import 'package:food_app_task/features/auth/domain/service/auth_service.dart';
import 'package:food_app_task/features/auth/domain/service/auth_service_interface.dart';
import 'package:food_app_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // repository
    AuthRepoInterface authRepo = AuthRepo(storage: Get.find());
    Get.lazyPut(() => authRepo, fenix: true);

    // service
    AuthServiceInterface authService = AuthService(authRepo: Get.find());
    Get.lazyPut(() => authService, fenix: true);

    // controller
    Get.lazyPut(() => AuthController(authService: Get.find()), fenix: true);
  }
}
