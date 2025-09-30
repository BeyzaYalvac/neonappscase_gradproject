import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';

Future<dynamic> createFolderSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(AppStrings.createFolderAlertTitle),
      content: const Text(AppStrings.createFolderAlertContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.createFolderAlertButtonText),
        ),
      ],
    ),
  );
}
