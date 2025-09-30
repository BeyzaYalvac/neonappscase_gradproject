import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';

Future<dynamic> uploadSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(AppStrings.uploadAlertTitle),
      content: const Text(AppStrings.uploadAlertContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.uploadAlertButtonText),
        ),
      ],
    ),
  );
}
