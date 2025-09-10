import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/core/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/core/extensions/widget_extensions.dart';

class SplashContainerToLeft extends StatelessWidget {
  final Widget textW;
  SplashContainerToLeft({super.key, required this.textW});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.2,
      width: AppMediaQuery.screenWidth(context) * 0.95,
      decoration: BoxDecoration(
        color: AppColors.bgTriartry,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(46),
          bottomLeft: Radius.circular(46),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: textW,
      ).withPadding(EdgeInsets.all(MediaQuery.of(context).size.width * 0.05)),
    );
  }
}
