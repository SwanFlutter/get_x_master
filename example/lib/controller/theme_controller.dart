import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class ThemeController extends GetXController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );

  ThemeData get currentTheme => isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
    // Update GetX theme
    Get.changeThemeMode(themeMode.value);
  }
}
