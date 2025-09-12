import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/widget/container/onboard_container_left.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/widget/container/onboard_container_right.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/widget/container/splash_gradient_bg.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/core/extensions/widget_extensions.dart';

/// 1) Uygulama adının göründüğü body
class SplashWelcomeBody extends StatelessWidget {
  const SplashWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Containerlar
        Column(
          children: [
            SplashContainerToLeft(
                  containerColor: AppColors.bgTriartry,
                  textW: Text(
                    AppStrings.appName,
                    style: AppTextSytlyes.splashWelcomeStyle,
                    textAlign: TextAlign.center,
                  ),
                )
                .withAlignment(Alignment.topRight)
                .withPadding(const EdgeInsets.only(top: 150)),
            SplashContainerToRight(
                  containerColor: AppColors.textLight,
                  textW: Text(
                    AppStrings.appSplashParagraph,
                    style: AppTextSytlyes.splashWelcomeSubtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                )
                .withAlignment(Alignment.centerLeft)
                .withPadding(const EdgeInsets.only(top: 60)),
          ],
        ),
        splash_gradient_bg(),
      ],
    );
  }
}
