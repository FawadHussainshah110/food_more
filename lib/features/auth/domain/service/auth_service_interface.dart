import '../../data/model/user_model.dart';

abstract class AuthServiceInterface {
  Future<UserModel?> loginWithGoogle();
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
