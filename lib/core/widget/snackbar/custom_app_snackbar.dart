import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class CustomAppSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    ContentType type = ContentType.help,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textTransparent,
        duration: const Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: type,
        ),
      ),
    );
  }

  // Kısayol metotlar
  static void success(
    BuildContext context,
    String message, 
    String title,
  ) =>
      show(context, title: title, message: message, type: ContentType.success);

  static void error(
    BuildContext context,
    String message, title,
  ) =>
      show(context, title: title, message: message, type: ContentType.failure);

  static void warning(
    BuildContext context,
    String message, 
    String title ,
  ) =>
      show(context, title: title, message: message, type: ContentType.warning);

  static void info(
    BuildContext context,
    String message,
    String title) => show(context, title: title, message: message, type: ContentType.help);
}
