import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homepage_listLayout_file.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homepage_listLayout_image.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/homepage_gridLayout_folder.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homePage_gridLayout_file_build.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/homePage_sections_tab.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/homepage_grid_toggleTabs.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/homepage_listLayout_folder.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class HomePageWhiteBody extends StatelessWidget {
  const HomePageWhiteBody({super.key, required this.isGrid});

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppMediaQuery.screenHeight(context) * 0.35,
      child: Container(
        width: AppMediaQuery.screenWidth(context),
        height: AppMediaQuery.screenHeight(context) * 0.65,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgPrimary
              : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              AppPaddings.CustomHeightSizedBox(context, 0.02),
              Row(
                children: [
                  Text(
                        "Recent Files",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                        ),
                      )
                      .withAlignment(Alignment.centerLeft)
                      .withPadding(
                        EdgeInsets.symmetric(
                          horizontal: AppMediaQuery.screenWidth(context) * 0.05,
                        ),
                      ),
                  GridToggleTabs(),
                ],
              ),
              AppPaddings.CustomHeightSizedBox(context, 0.01),

              // SAYFA ORTASINDA TAB BAR (AppBar ile alakası yok)
              HomePageSectionTabs(),

              AppPaddings.CustomHeightSizedBox(context, 0.02),

              // TAB İÇERİKLERİ
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1: Folder
                    isGrid
                        ? HomePageFolderGridLayoutTabFolder()
                        : HomePageFolderListLayoutTabFolder(),

                    // Tab 2: File
                    isGrid
                        ? HomePageGridLayoutTabFileImage()
                        : HomePageListLayoutTabFile(),

                    // Tab 3: Image
                    isGrid
                        ? HomePageGridLayoutTabFileImage()
                        : HomePageListLayoutTabImage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
