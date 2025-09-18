import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class HomePageSectionTabs extends StatelessWidget {
  const HomePageSectionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppMediaQuery.screenWidth(context),

      child: Container(
        child: TabBar(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.screenWidth(context) / 8,
          ),
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: AppColors.textWhite,
          unselectedLabelColor: AppColors.bgQuaternary,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.bgTriartry,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          tabs: [
            Tab(text: AppStrings.folderTabText),
            Tab(text: AppStrings.fileTabText),
            Tab(text: AppStrings.imageTabText),
          ],
        ),
      ),
    );
  }
}
