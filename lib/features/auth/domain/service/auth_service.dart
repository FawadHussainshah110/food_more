import 'package:food_app_task/features/auth/data/model/user_model.dart';
import 'package:food_app_task/features/auth/data/repository/auth_repo_interface.dart';

import 'auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthRepoInterface authRepo;

  AuthService({required this.authRepo});

  @override
  Future<UserModel?> loginWithGoogle() {
    return authRepo.loginWithGoogle();
  }

  @override
  Future<void> logout() {
    return authRepo.logout();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return authRepo.getCurrentUser();
  }
}
