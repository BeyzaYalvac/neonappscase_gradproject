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

      child: TabBar(
        /*padding: EdgeInsets.only(
          //left: AppMediaQuery.screenWidth(context) * 0.1,
          //right: AppMediaQuery.screenWidth(context) * 0.1,
        ),*/
        tabAlignment: TabAlignment.center,
        dividerHeight: 0,

        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelColor: AppColors.textBej,
        unselectedLabelColor: Theme.of(context).brightness == Brightness.light
            ? AppColors.bgPrimary
            : AppColors.bgTriartry,
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          //color: AppColors.bgTriartry,
          border: BoxBorder.fromLTRB(
            bottom: BorderSide(width: 3, color: AppColors.bgPrimary),
          ),
          //borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        tabs: [
          Tab(text: AppStrings.folderTabText),
          Tab(text: AppStrings.fileTabText),
          Tab(text: AppStrings.imageTabText),
        ],
      ),
    );
  }
}
