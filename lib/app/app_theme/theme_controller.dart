import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_theme.dart';

class ThemeController extends GetxController {
  // Observable for dark mode
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Optional: Load saved theme from GetStorage or default
    // isDarkMode.value = GetStorage().read('isDarkMode') ?? false;
  }

  // Toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    // Optional: Save theme to storage
    // GetStorage().write('isDarkMode', isDarkMode.value);
  }

  // Get current theme
  ThemeData get theme => isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme;
}
