import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/card/grid_folder_card.dart';

class HomePageFolderGridLayoutTabFolder extends StatelessWidget {
  final List<ContentModel> filteredFolders;
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
          child: GridFolderCard(folderName: filteredFolders[index].name),
        );
      },
    );
  }
}
