import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/all/listview/all_listtile.dart';

class AllListView extends StatelessWidget {
  const AllListView({
    super.key,
    required this.total,
    required this.folders,
    required this.files,
    required this.state,
    required this.images,
  });

  final int total;
  final List<FileFolderListModel> folders;
  final List<FileItem> files;
  final HomeState state;
  final List<FileItem> images;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: total,
      itemBuilder: (context, i) {
        final fLen = folders.length;
        final fiLen = files.length;

        if (i < fLen) {
          final f = folders[i];
          return AllListTile(
            icon: Icons.folder,
            label: f.name,
            onTap: () {
              context.router.push(
                ItemDetailRoute(item: f, oldFolderName: state.selectedFolder),
              );
            },
          );
        }

        if (i < fLen + fiLen) {
          final file = files[i - fLen];
          return AllListTile(label: file.name, icon: Icons.file_copy);
        }

        final img = images[i - fLen - fiLen];
        return AllListTile(label: img.name, icon: Icons.image);
      },
    );
  }
}
