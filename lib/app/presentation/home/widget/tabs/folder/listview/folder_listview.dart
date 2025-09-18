import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/listview/listile/folder_listile.dart';

class HomePageFolderListLayoutTabFolder extends StatelessWidget {
  final List<FileFolderListModel> filteredFolders;
  const HomePageFolderListLayoutTabFolder({
    super.key,
    required this.filteredFolders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.screenWidth(context) * 0.05,
      ),
      itemCount: filteredFolders.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.router.push(ItemDetailRoute(item: filteredFolders[index]));
          },
          child: FolderListile(filteredFolders: filteredFolders, index: index),
        );
      },
    );
  }
}
