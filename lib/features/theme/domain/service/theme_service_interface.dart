import 'package:flutter/material.dart';

abstract class ThemeServiceInterface {
  Future<ThemeMode> loadCurrentTheme();
  Future<bool> saveThemeMode(ThemeMode themeMode);
}
