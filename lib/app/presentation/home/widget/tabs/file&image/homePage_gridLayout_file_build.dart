import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/card/grid_card.dart';

class HomePageGridLayoutTabFileImage extends StatelessWidget {
  final List<FileItem> filteredItems;
  const HomePageGridLayoutTabFileImage({super.key, required this.filteredItems,  });

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
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GridCard(file: filteredItems[index]),
        );
      },
    );
  }
}

