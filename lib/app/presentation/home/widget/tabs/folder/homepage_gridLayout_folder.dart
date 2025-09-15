import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/card/grid_folder_card.dart';

class HomePageFolderGridLayoutTabFolder extends StatelessWidget {
  final List<FileFolderListModel> filteredFolders;
  const HomePageFolderGridLayoutTabFolder({
    super.key,
    required this.filteredFolders,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredFolders.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              context.router.push(
                ItemDetailRoute(item: filteredFolders[index]),
              );
            },
            child: GridFolderCard(folderName: filteredFolders[index].name),
          ),
        );
      },
    );
  }
}
