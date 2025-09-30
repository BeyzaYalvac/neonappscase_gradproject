import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/blue_body.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/gridview%20file_image/file_gridlayout.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_file/listlayout_file.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_image/list_layout_image.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/gridview/folder_gridview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/listview/folder_listview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/tabs%20sections/all_items_tab.dart';

class BlueBodyContentTab extends StatelessWidget {
  const BlueBodyContentTab({
    super.key,
    required this.widget,
    required this.state
  });

  final HomePageBlueBody widget;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMediaQuery.screenHeight(context) * 0.5,
      child: TabBarView(
        children: [
          AllItemsBody(isGrid: widget.isGrid, state: state),
    
          widget.isGrid
              ? HomePageFolderGridLayoutTabFolder(
                  filteredFolders: state.folders,
                )
              : HomePageFolderListLayoutTabFolder(
                  filteredFolders: state.folders,
                ),
          widget.isGrid
              ? HomePageGridLayoutTabFileImage(
                  filteredItems: state.files,
                )
              : HomePageListLayoutTabFile(
                  filteredFiles: state.files,
                ),
          widget.isGrid
              ? HomePageGridLayoutTabFileImage(
                  filteredItems: state.images,
                )
              : HomePageListLayoutTabImage(
                  filteredImages: state.images,
                ),
        ],
      ),
    );
  }
}
