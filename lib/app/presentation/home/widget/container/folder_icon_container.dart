import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class FolderIconContainer extends StatelessWidget {
  const FolderIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppMediaQuery.screenHeight(context) * 0.11,
      width: AppMediaQuery.screenWidth(context) * 0.5,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bgSmoothLight, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppIcons.folderLarge,
    );
  }
}
