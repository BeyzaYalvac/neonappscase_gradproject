
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';

class FavoritesEmpty extends StatelessWidget {
  const FavoritesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppPaddings.customHeightSizedBox(context, 0.08),
        Center(
          child: Transform.scale(
            scale: 4, // 1.0 = orijinal
            child: Lottie.asset(
              AppAssets.favoriteAnimation,
              width: AppMediaQuery.screenWidth(context) * 0.8,
              height: AppMediaQuery.screenWidth(context) * 0.8,
            ),
          ),
        ),
        Text(
          AppStrings.favoriteFileText,
          style: AppTextSytlyes.favoriteFileTextStyle,
        ),
      ],
    );
  }
}
