import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class MainUsedText extends StatelessWidget {
  const MainUsedText({super.key, required this.storageGb});

  final double storageGb;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.04,
      width: AppMediaQuery.screenWidth(context) * 0.32,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),

        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgPrimary
            : AppColors.bgwhiteBlue,
      ),

      child: Center(
        child: Text(
          ' Used  ${storageGb.toStringAsFixed(3)} GB',
          style: AppTextSytlyes.usedMainTextStyle(context),
        ).withPadding(EdgeInsetsGeometry.only(right: AppPaddings.small)),
      ),
    );
  }
}

class MainUsedIcon extends StatelessWidget {
  const MainUsedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.04,

      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgPrimary
            : AppColors.bgwhiteBlue,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.circle,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : AppColors.bgSmoothDark,
          size: 16,
        ).withPadding(EdgeInsetsGeometry.only(left: AppPaddings.small)),
      ),
    );
  }
}

class MainTotalText extends StatelessWidget {
  const MainTotalText({super.key, required this.storageCanUsed});

  final double storageCanUsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.04,
      width: AppMediaQuery.screenWidth(context) * 0.32,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),

        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgQuaternary
            : AppColors.bgTransparent,
      ),
      child: Text(
        " Total 5 GB",
        style: AppTextSytlyes.totalMainTextStyle(context),
      ).withCenter(),
    );
  }
}

class MainTotalIcon extends StatelessWidget {
  const MainTotalIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.04,

      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgQuaternary
            : AppColors.bgTransparent,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Icon(
        Icons.circle,
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgPrimary
            : AppColors.bgwhiteBlue,
        size: 16,
      ).withPadding(EdgeInsetsGeometry.only(left: AppPaddings.small)),
    );
  }
}
