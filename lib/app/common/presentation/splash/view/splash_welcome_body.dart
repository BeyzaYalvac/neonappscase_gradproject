import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/core/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/core/extensions/widget_extensions.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/widget/onboard_container_left.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/widget/onboard_container_right.dart';

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
                  textW: Text(
                    AppStrings.appName,
                    style: AppTextSytlyes.splashWelcomeStyle,
                    textAlign: TextAlign.center,
                  ),
                )
                .withAlignment(Alignment.topRight)
                .withPadding(const EdgeInsets.only(top: 150)),
            SplashContainerToRight(
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
      ],
    );
  }
}
