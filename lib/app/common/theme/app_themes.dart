import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textLight,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textMedium),
      bodySmall: TextStyle(color: AppColors.textLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.textMedium,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColors.bgSecondary,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textMedium),
      bodyMedium: TextStyle(color: AppColors.textLight),
      bodySmall: TextStyle(color: AppColors.bgPrimary),
    ),
  );
}
