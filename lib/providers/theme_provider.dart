import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tnp_rgpv_app/models/theme_model.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme) {
    _init();
  }

  void setTheme(ThemeData theme, String themeName) {
    state = theme;
    ThemePersistence.saveTheme(themeName);
  }

  void setCustomSeedColor(ColorSeed seedColor) {
    state = customTheme(seedColor.color);
    ThemePersistence.saveSeedColor(seedColor);
  }

  Future<void> _init() async {
    await _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeName = await ThemePersistence.loadTheme();
    final seedColor = await ThemePersistence.loadSeedColor();

    print('ThemeSet = $themeName');
    switch (themeName) {
      case 'dark':
        state = darkTheme;
        break;
      case 'custom':
        state = customTheme(seedColor.color);
        break;
      default:
        state = lightTheme;
        break;
    }
  }
}

class ThemePersistence {
  static const _themeKey = 'theme_mode';
  static const _seedColorKey = 'seed_color';

  static Future<void> saveTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeName);
  }

  static Future<String> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'light';
  }

  static Future<void> saveSeedColor(ColorSeed seedColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_seedColorKey, seedColor.name);
  }

  static Future<ColorSeed> loadSeedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final seedColorName = prefs.getString(_seedColorKey) ?? 'baseColor';
    return ColorSeed.values.firstWhere((e) => e.name == seedColorName);
  }
}
