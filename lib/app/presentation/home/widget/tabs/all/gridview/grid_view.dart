import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/all/gridview/all_gridtile.dart';

class AllGridView extends StatelessWidget {
  const AllGridView({super.key, 
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
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      itemCount: total,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, i) {
        final fLen = folders.length;
        final fiLen = files.length;
    
        if (i < fLen) {
          final f = folders[i];
          return AllGridTile(
            icon: Icons.folder,
            label: f.name,
            onTap: () => context.router.push(
              ItemDetailRoute(item: f, oldFolderName: state.selectedFolder),
            ),
          );
        }
    
        if (i < fLen + fiLen) {
          final file = files[i - fLen];
          return AllGridTile(icon: Icons.insert_drive_file, label: file.name);
        }
    
        final img = images[i - fLen - fiLen];
        return AllGridTile(icon: Icons.image, label: img.name);
      },
    );
  }
}
