import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/container/onboard_container_left.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/container/onboard_container_right.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/widget/container/splash_gradient_bg.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

/// 2) Uygulama açıklamalarının olduğu body
class SplashDescriptionBody extends StatelessWidget {
  const SplashDescriptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              SplashContainerToRight(
                    textW: Text(
                      AppStrings.appSplashWelcome,
                      style: AppTextSytlyes.splashWelcomeStyle,
                      textAlign: TextAlign.center,
                    ).withCenter(),
                    containerColor: AppColors.bgTriartry,
                  )
                  .withAlignment(Alignment.topLeft)
                  .withPadding(const EdgeInsets.only(top: 150)),
              SplashContainerToLeft(
                    textW: Text(
                      AppStrings.appSplashParagraph2,
                      style: AppTextSytlyes.splashWelcomeSubtitleStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                    ),
                    containerColor: AppColors.textLight,
                  )
                  .withAlignment(Alignment.centerRight)
                  .withPadding(const EdgeInsets.only(top: 60)),
            ],
          ),
          splash_gradient_bg(),
        ],
      ),
    );
  }
}
