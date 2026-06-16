import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'theme_repo_interface.dart';

class ThemeRepo implements ThemeRepoInterface {
  final FlutterSecureStorage storage;
  ThemeRepo({required this.storage});

  @override
  Future<String> loadCurrentTheme() async {
    return await storage.read(key: 'theme') ?? 'system';
  }

  @override
  Future<bool> saveThemeMode(String themeMode) async {
    await storage.write(key: 'theme', value: themeMode);
    return true;
  }
}
