import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppTheme {
  // Tek bir yardımcı: AppColors'tan ColorScheme üret
  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.bgPrimary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.bgTriartry,
        secondary: AppColors.bgSecondary,
        tertiary: AppColors.bgTriartry,
        onPrimary: AppColors.textLight,
        surface: AppColors.bgTriartry,
      );

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.bgSecondary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.bgPrimary,
        secondary: AppColors.bgSecondary,
        tertiary: AppColors.bgTriartry,
        onPrimary: Colors.white,
        surface: AppColors.bgSecondary,
      );

  static ThemeData lightTheme = ThemeData(
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.fixed,
      insetPadding: EdgeInsets.zero,
    ),

    useMaterial3: true,
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: _lightScheme.surface,
    appBarTheme: const AppBarTheme(centerTitle: true),
    // scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textMedium),
      bodySmall: TextStyle(color: AppColors.textLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.fixed,
      insetPadding: EdgeInsets.zero,
    ),
    useMaterial3: true,
    colorScheme: _darkScheme,
    appBarTheme: const AppBarTheme(centerTitle: true),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight),
      bodyMedium: TextStyle(color: AppColors.textLight),
      bodySmall: TextStyle(color: AppColors.bgPrimary),
    ),
  );
}
