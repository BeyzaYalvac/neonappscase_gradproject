import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/moveFile_dialog.dart';

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
    return PopupMenuButton<_fileAction>(
      icon: Theme.of(context).brightness == Brightness.light
          ? AppIcons.more_horiz
          : AppIcons.more_horiz_blue,
      tooltip: AppStrings.fileProcesses,
      onSelected: (action) {
        switch (action) {
          case _fileAction.move:
            final state = context.read<HomeCubit>().state;
            MoveFileDialog(context, state, filteredFiles[index]);
            break;
          case _fileAction.favorite:
            final key = filteredFiles[index].link;
            final isFavoriteFile = cubit.isFavoriteFile(key);
            if (isFavoriteFile) {
              cubit.removeFavoriteFileByKey(key);
            } else {
              cubit.addFavoriteFile(filteredFiles[index]);
            }
            break;
          case _fileAction.download:
            context.read<HomeCubit>().downloadFile(filteredFiles[index].link);
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: _fileAction.move,
            child: ListTile(
              leading: Theme.of(context).brightness == Brightness.light
                  ? AppIcons.file_move_blue
                  : AppIcons.file_move,
              title: Text(AppStrings.moveText),
            ),
          ),
          PopupMenuItem(
            value: _fileAction.favorite,
            child: ListTile(
              leading: isFavoriteFile
                  ? AppIcons.star(context)
                  : Theme.of(context).brightness == Brightness.light
                  ? AppIcons.star_border(context)
                  : AppIcons.star_border_blue(context),
              title: Text(
                isFavoriteFile
                    ? AppStrings.removeFavorites
                    : AppStrings.addFavorites,
              ),
            ),
          ),
          PopupMenuItem(
            value: _fileAction.download,
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

enum _fileAction { favorite, move, download }
