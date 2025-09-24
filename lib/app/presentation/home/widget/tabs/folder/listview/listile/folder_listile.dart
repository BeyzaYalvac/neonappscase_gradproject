import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/renameFolder_dialog.dart';

class FolderListile extends StatelessWidget {
  final int index;
  const FolderListile({
    super.key,
    required this.filteredFolders,
    required this.index,
  });

  final List<FileFolderListModel> filteredFolders;

  @override
  Widget build(BuildContext context) {
    final TextEditingController folderNameController = TextEditingController(
      text: filteredFolders[index].name,
    );

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();
        final isFavoriteFolder = state.favoriteFolders.any(
          (fav) =>
              fav['id'] == filteredFolders[index].fldId &&
              fav['type'] == 'folder',
        );

        return ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme.of(context).brightness == Brightness.light
                  ? AppIcons.folder(context)
                  : AppIcons.folder_blue(context),
            ],
          ),
          title: Text(
            filteredFolders[index].name,
            style: TextStyle(
              color: AppTextSytlyes.fileNameTextStyle(context).color,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: PopupMenuButton<_FolderAction>(
            icon: Theme.of(context).brightness == Brightness.light
                ? AppIcons.more_horiz
                : AppIcons.more_horiz_blue,
            tooltip: AppStrings.folderProcesses,
            onSelected: (action) {
              switch (action) {
                case _FolderAction.rename:
                  RenameDialog(
                    context,
                    folderNameController,
                    filteredFolders[index],
                  );

                case _FolderAction.favorite:
                  if (isFavoriteFolder) {
                    cubit.removeFavoriteFolder(filteredFolders[index].fldId);
                  } else {
                    cubit.addFavoriteFolder(filteredFolders[index]);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _FolderAction.rename,
                  child: ListTile(
                    leading: Theme.of(context).brightness == Brightness.light
                        ? AppIcons.rename_blue
                        : AppIcons.rename,
                    title: Text(AppStrings.folderProcesses),
                  ),
                ),
                PopupMenuItem(
                  value: _FolderAction.favorite,
                  child: ListTile(
                    leading: isFavoriteFolder
                        ? AppIcons.star(context)
                        : Theme.of(context).brightness == Brightness.light
                        ? AppIcons.star_border(context)
                        : AppIcons.star_border_blue(context),
                    title: Text(
                      isFavoriteFolder
                          ? AppStrings.removeFavorites
                          : AppStrings.addFavorites,
                    ),
                  ),
                ),
              ];
            },
          ),
        );
      },
    );
  }
}

enum _FolderAction { rename, favorite }
