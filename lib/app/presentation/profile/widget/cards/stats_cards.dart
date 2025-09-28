
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/profile_status_cards.dart';

class Stats extends StatelessWidget {
  const Stats({
    super.key,
    required this.w,
    required this.used,
    required this.h,
    required this.traficLeft,
  });

  final double w;
  final String used;
  final double h;
  final String? traficLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatCard(
            title: AppStrings.usedProfileText,
            value: used,
            height: h * 0.18,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgSmoothDark
                : AppColors.bgPrimary,
          ),
          StatCard(
            title: AppStrings.leftProfileText,
            value: traficLeft ?? 'N/A',
            height: h * 0.18,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgSmoothDark
                : AppColors.bgPrimary,
          ),
        ],
      ),
    );
  }
}
