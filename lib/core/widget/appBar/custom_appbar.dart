import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';
import 'package:neonappscase_gradproject/core/widget/button/theme_toggle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.appName,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : AppColors.bgPrimary,
        ),
      ),
      actions: [
        LottieThemeToggle().withPadding(
          EdgeInsetsGeometry.only(
            right: AppMediaQuery.screenWidth(context) * 0.05,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgPrimary
          : AppColors.bgSmoothDark,
      foregroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgTriartry
          : AppColors.bgPrimary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
