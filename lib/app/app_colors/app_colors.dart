import 'package:flutter/material.dart';

/// ============================
/// APP COLORS (DO NOT CHANGE)
/// ============================
class AppColors {
  AppColors._(); // Private constructor taake is class ka object na ban sake

  /// App ka main brand color
  /// Use karo: AppBar, Primary buttons, Active states, Highlights ke liye
  static const Color primary = Color(0xFF5E17EB);

  /// Secondary accent color
  /// Use karo: Secondary buttons, Icons, Chips, Badges ke liye
  static const Color secondary = Color(0xFFFF9800);

  /// App ka background color
  /// Use karo: Scaffold background, har screen ke background ke liye
  static const Color background = Color(0xFFF4F6FA);

  /// Surface color
  /// Use karo: Cards, Containers, BottomSheets, Dialog backgrounds ke liye
  static const Color surface = Color(0xFFFFFFFF);

  /// Primary text color
  /// Use karo: Headings, Titles, Important text ke liye
  static const Color textPrimary = Color(0xFF000000);

  /// Secondary text color
  /// Use karo: Subtitles, Descriptions, Hint text ke liye
  static const Color textSecondary = Color(0xFF757575);

  /// Error color
  /// Use karo: Error messages, Validation errors, Alerts ke liye
  static const Color error = Color(0xFFE53935);

  /// Success color
  /// Use karo: Success messages, Completed states, Positive actions ke liye
  static const Color success = Color(0xFF43A047);

  // Light Mode
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1E1E1E);
  static const Color lightTextSecondary = Color(0xFF6B6B6B);

  // Dark Mode
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);
}

/// ============================
/// APP THEME COLORS (AUTO LIGHT/DARK)
/// ============================
class AppThemeColors {
  AppThemeColors._(); // private constructor

  static bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // ================= BACKGROUND =================
  static Color background(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBackground
        : AppColors.lightBackground;
  }

  // ================= TEXT =================
  static Color textPrimary(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
  }

  static Color textSecondary(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
  }

  // ================= SURFACE (Cards, Containers) =================
  static Color surface(BuildContext context) {
    return _isDark(context)
        ? const Color(0xFF2A2A2A)
        : AppColors.surface;
  }

  // ================= ICONS =================
  static Color icon(BuildContext context) {
    return AppColors.primary; // same in both themes
  }

  // ================= BUTTON =================
  static Color buttonPrimary(BuildContext context) {
    return AppColors.primary;
  }

  static Color buttonText(BuildContext context) {
    return Colors.white;
  }

  // ================= BORDER =================
  static Color border(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextSecondary.withOpacity(0.3)
        : AppColors.lightTextSecondary.withOpacity(0.3);
  }

  // ================= SUCCESS =================
  static Color success(BuildContext context) {
    return AppColors.success;
  }

  // ================= ERROR =================
  static Color error(BuildContext context) {
    return AppColors.error;
  }
}