import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppTextSytlyes {
  static const TextStyle appNameTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
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

  //Profile Status Card
  static const TextStyle profileStatusBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileStatusBoldAndSizedTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppMediaQuery.screenWidth(context) * 0.08,
    );
  }

  //onboarding Button
  static const TextStyle onboardingButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.1,
  );

  //Favorite Page
  static const TextStyle favoriteFileTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  //Upload Page
  static TextStyle uploadFileTextStyle_1 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  //home page
  static const TextStyle whiteTextStyle = TextStyle(color: AppColors.textWhite);
  static const TextStyle listViewTextStyle = TextStyle(
    color: AppColors.textWhite,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle primaryColorTextStyle = TextStyle(
    color: AppColors.textMedium,
  );

  static TextStyle totalMainTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textWhite
          : AppColors.bgwhiteBlue,

      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle usedMainTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgTriartry
          : AppColors.purple,
      fontWeight: FontWeight.w600,
    );
  }

  static const TextStyle smootLightTextStyle = TextStyle(
    color: AppColors.bgSmoothLight,
  );

  //blue body
  static TextStyle recentFileTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textWhite
          : AppColors.bgSmoothLight,
      fontWeight: FontWeight.bold,
      fontSize: AppMediaQuery.screenWidth(context) * 0.05,
    );
  }

  //selectrootfolderdropdown
  static TextStyle dropDownTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textMedium
          : AppColors.textWhite,
    );
  }

  //itemdetail
  static const TextStyle darkTextStyle = TextStyle(color: AppColors.textDark);
  static const TextStyle whiteItemTextStyle = TextStyle(
    color: AppColors.textWhite,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  //file listTile
  static TextStyle fileTileTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgPrimary
          : AppColors.bgSmoothLight,
    );
  }

  static TextStyle fileNameTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textBej
          : AppColors.bgSmoothLight,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
  }

  //create folder alert
  TextStyle boldTextStyle() => TextStyle(fontWeight: FontWeight.bold);
  TextStyle cancelTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textSmoothDark
          : AppColors.bgwhiteBlue,
      fontWeight: FontWeight.normal,
    );
  }

  //emptycardstate
  TextStyle emptyCardTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textMedium
          : AppColors.textWhite,
      fontSize: AppMediaQuery.screenWidth(context) * 0.06,
    );
  }

  //appbarname
  TextStyle appBarNameStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgTriartry
          : AppColors.bgPrimary,
    );
  }

  //profile page
  static TextStyle eMailTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppMediaQuery.screenWidth(context) * 0.04,
      fontWeight: FontWeight.bold,
      color: AppColors.textMedium,
    );
  }

  static TextStyle currStorage(BuildContext context) {
    return TextStyle(
      fontSize: AppMediaQuery.screenWidth(context) * 0.035,
      fontWeight: FontWeight.w600,
    );
  }

  //upload page
  TextStyle uploadFileTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.brightness == Brightness.light
          ? AppColors.textMedium
          : AppColors.textWhite,
      fontSize: AppMediaQuery.screenWidth(context) * 0.06,
    );
  }

  //tabs
  TextStyle tabUnselectedTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      
    );
  }

  //selectanyfolder
  TextStyle selectAnyFolderTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.textMedium
          : AppColors.textWhite,
    );
  }

  TextStyle gridCardNameTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold, color: AppColors.bgTriartry);
  }

  TextStyle gridCardMotifiedTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      color: (Theme.of(context).brightness == Brightness.light)
          ? AppColors.textMedium
          : AppColors.bgSmoothDark,
    );
  }

  //hompage Summary Header

  TextStyle usedTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textMedium,
    );
  }

  TextStyle percentTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textWhite
          : AppColors.textMedium,
    );
  }
}
