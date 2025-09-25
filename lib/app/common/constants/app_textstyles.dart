import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppTextSytlyes {
  static const TextStyle appNameTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  //splash
  static const TextStyle splashSubtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
  );
  static const TextStyle splashWelcomeStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.textBej,
  );
  static const TextStyle splashWelcomeSubtitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );

  //Favorite Page
  static const TextStyle favoriteFileTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  //Upload Page
  static const TextStyle uploadFileTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  //home page
  static const TextStyle whiteTextStyle = TextStyle(color: AppColors.textWhite);
  static const TextStyle primaryColorTextStyle = TextStyle(
    color: AppColors.textMedium,
  );

  static TextStyle fileNameTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textBej
          : AppColors.bgSmoothLight,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
  }
}
