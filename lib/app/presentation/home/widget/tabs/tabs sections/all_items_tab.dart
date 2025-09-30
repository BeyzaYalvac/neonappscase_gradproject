import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/all/gridview/grid_view.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/all/listview/all_listview.dart';

class AllItemsBody extends StatelessWidget {
  const AllItemsBody({super.key, required this.isGrid, required this.state});

  final bool isGrid;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final folders = state.folders;
    final files = state.files;
    final images = state.images;

    final total = folders.length + files.length + images.length;

    if (total == 0) {
      return const Center(
        child: ListTile(
          leading: Icon(Icons.inbox_outlined),
          title: Text(AppStrings.noItemText),
        ),
      );
    }

    if (isGrid) {
      // Grid görünümm
      return AllGridView(
        total: total,
        folders: folders,
        files: files,
        state: state,
        images: images,
      );
    } else {
      // List görünüm
      return AllListView(
        total: total,
        folders: folders,
        files: files,
        state: state,
        images: images,
      );
    }
  }
}
