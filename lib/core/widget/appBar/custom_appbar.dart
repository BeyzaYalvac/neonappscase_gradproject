import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/core/widget/button/theme_toggle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        AppStrings.appName,
        style: TextStyle(color: AppColors.textWhite),
      ),
      actions: const [LottieThemeToggle()],
      backgroundColor: AppColors.bgTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
