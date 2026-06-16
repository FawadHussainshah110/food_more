import 'package:food_app_task/features/auth/data/model/user_model.dart';
import 'package:food_app_task/features/auth/domain/service/auth_service_interface.dart';
import 'package:food_app_task/features/dashboard/presentation/view/dashboard_screen.dart';
import 'package:food_app_task/imports.dart';

class AuthController extends GetxController {
  final AuthServiceInterface authService;

  AuthController({required this.authService}) {
    checkCurrentUser();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  set currentUser(UserModel? value) {
    _currentUser = value;
    if (value != null) {
      debugPrint('Logged in user: ${value.name} (Email: ${value.email}, UID: ${value.uid})');
    }
    update();
  }

  void checkCurrentUser() async {
    final user = await authService.getCurrentUser();
    if (user != null) {
      currentUser = user;
    } else {
      debugPrint('No user logged in');
    }
  }

  void loginWithGoogle() async {
    isLoading = true;
    try {
      final user = await authService.loginWithGoogle();
      if (user != null) {
        currentUser = user;
        showCustomSnackBar('Signed in with Google as ${user.name}!', isError: false);
        launchScreen(const DashboardScreen(), pushAndRemove: true);
      } else {
        showCustomSnackBar('Google Sign-In Error', isError: true);
      }
    } catch (e) {
      showCustomSnackBar('Google Sign-In failed: ${e.toString()}', isError: true);
    } finally {
      isLoading = false;
    }
  }

  void logout() async {
    isLoading = true;
    try {
      await authService.logout();
      currentUser = null;
      showCustomSnackBar('Signed out successfully', isError: false);
    } catch (e) {
      showCustomSnackBar('Error signing out', isError: true);
    } finally {
      isLoading = false;
    }
  }

  static AuthController get find => Get.find<AuthController>();
}
