import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppTheme {
  // Tek bir yardımcı: AppColors'tan ColorScheme üret
  static ColorScheme _lightScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.bgPrimary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.bgTriartry,
        secondary: AppColors.bgSecondary,
        tertiary: AppColors.bgTriartry,
        onPrimary: AppColors.textLight,
        background: AppColors.bgPrimary,
      );

  static ColorScheme _darkScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.bgSecondary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.bgPrimary,
        secondary: AppColors.bgSecondary,
        tertiary: AppColors.bgTriartry,
        onPrimary: Colors.white,
        background: AppColors.bgSecondary,
      );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: _lightScheme.background,
    // AppBar’ı sabitleme! Varsayılanı ColorScheme’den gelsin:
    appBarTheme: const AppBarTheme(centerTitle: true),
    // Scaffold’u da sabitleme; ColorScheme.surface kullansın:
    // scaffoldBackgroundColor: Colors.white,  <-- SİL
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textMedium),
      bodySmall: TextStyle(color: AppColors.textLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkScheme,
    appBarTheme: const AppBarTheme(centerTitle: true),
    // scaffoldBackgroundColor: AppColors.bgSecondary,  <-- SİL
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textMedium),
      bodyMedium: TextStyle(color: AppColors.textLight),
      bodySmall: TextStyle(color: AppColors.bgPrimary),
    ),
  );
}
