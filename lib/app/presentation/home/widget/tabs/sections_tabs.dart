import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class HomePageSectionTabs extends StatelessWidget {
  const HomePageSectionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppMediaQuery.screenWidth(context),

      child: TabBar(
       
        tabAlignment: TabAlignment.center,
        dividerHeight: 0,

        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelColor: AppColors.textBej,
        unselectedLabelColor: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgPrimary
            : AppColors.bgTriartry,
        unselectedLabelStyle: AppTextSytlyes().tabUnselectedTextStyle(context),
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          border: BoxBorder.fromLTRB(
            bottom: BorderSide(width: 3, color: AppColors.bgPrimary),
          ),
        ),
        tabs: [
          Tab(text: "All Contents"),
          Tab(text: AppStrings.folderTabText),
          Tab(text: AppStrings.fileTabText),
          Tab(text: AppStrings.imageTabText),
        ],
      ),
    );
  }
}
