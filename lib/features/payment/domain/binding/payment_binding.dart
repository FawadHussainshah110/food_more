import 'package:food_app_task/features/payment/data/repository/payment_repo.dart';
import 'package:food_app_task/features/payment/data/repository/payment_repo_interface.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily put http.Client if not already registered, using fenix: true to rebuild when needed
    if (!Get.isRegistered<http.Client>()) {
      Get.lazyPut<http.Client>(() => http.Client(), fenix: true);
    }
    Get.lazyPut<PaymentRepoInterface>(() => PaymentRepo(httpClient: Get.find()), fenix: true);
  }
}
