import '../model/user_model.dart';

abstract class AuthRepoInterface {
  Future<UserModel?> loginWithGoogle();
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
