import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/move_file_dialog.dart';

class FileActionsPopUpMenu extends StatelessWidget {
  const FileActionsPopUpMenu({
    super.key,
    required this.filteredFiles,
    required this.index,
    required this.isFavoriteFile,
    required this.cubit,
  });

  final List<FileItem> filteredFiles;
  final int index;
  final bool isFavoriteFile;
  final FavoriteCubit cubit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FileActions>(
      icon: Theme.of(context).brightness == Brightness.light
          ? AppIcons.moreHoriz
          : AppIcons.moreHorizBlue,
      tooltip: AppStrings.fileProcesses,
      onSelected: (action) {
        switch (action) {
          case FileActions.move:
            final state = context.read<HomeCubit>().state;
            moveFileDialog(context, state, filteredFiles[index]);
            break;
          case FileActions.favorite:
            final key = filteredFiles[index].link;
            final isFavoriteFile = cubit.isFavoriteFile(key);
            if (isFavoriteFile) {
              cubit.removeFavoriteFileByKey(key);
            } else {
              cubit.addFavoriteFile(filteredFiles[index]);
            }
            break;
          case FileActions.download:
            context.read<HomeCubit>().downloadFile(filteredFiles[index].link);
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: FileActions.move,
            child: ListTile(
              leading: Theme.of(context).brightness == Brightness.light
                  ? AppIcons.fileMoveBlue
                  : AppIcons.fileMove,
              title: Text(AppStrings.moveText),
            ),
          ),
          PopupMenuItem(
            value: FileActions.favorite,
            child: ListTile(
              leading: isFavoriteFile
                  ? AppIcons.star(context)
                  : Theme.of(context).brightness == Brightness.light
                  ? AppIcons.starBorder(context)
                  : AppIcons.starBorderBlue(context),
              title: Text(
                isFavoriteFile
                    ? AppStrings.removeFavorites
                    : AppStrings.addFavorites,
              ),
            ),
          ),
          PopupMenuItem(
            value: FileActions.download,
            child: ListTile(
              leading: AppIcons.download,
              title: Text(AppStrings.downloadText),
            ),
          ),
        ];
      },
    );
  }
}

enum FileActions { favorite, move, download }
