import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/gridtoggle_tabs.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class BlueBodyHeader extends StatelessWidget {
  const BlueBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
              AppStrings.recentFilesText,
              style: AppTextSytlyes.recentFileTextStyle(context),
            )
            .withAlignment(Alignment.centerLeft)
            .withPadding(
              EdgeInsets.symmetric(
                horizontal:
                    AppMediaQuery.screenWidth(context) * 0.05,
              ),
            ),
        const GridToggleTabs(),
      ],
    );
  }
}

