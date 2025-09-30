import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';

class FavoriteDeletedBanner extends MaterialBanner {
  FavoriteDeletedBanner({super.key})
    : super(
        content: const Text(AppStrings.deleteMaterialBannerText),
        leading: const Icon(Icons.check_circle),
        actions: [
          TextButton(
            onPressed: () => {},
            child: const Text(AppStrings.cancelText),
          ),
        ],
      );
}
