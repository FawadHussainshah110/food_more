abstract class ThemeRepoInterface {
  Future<String> loadCurrentTheme();
  Future<bool> saveThemeMode(String themeMode);
}
