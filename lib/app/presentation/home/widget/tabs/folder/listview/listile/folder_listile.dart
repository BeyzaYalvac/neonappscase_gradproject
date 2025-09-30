import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/rename_folder_dialog.dart';

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
                  : AppIcons.folderBlue(context),
            ],
          ),
          title: Text(
            filteredFolders[index].name,
            style: AppTextSytlyes.fileNameTextStyle(context)
          ),
          trailing: PopupMenuButton<_FolderAction>(
            icon: Theme.of(context).brightness == Brightness.light
                ? AppIcons.moreHoriz
                : AppIcons.moreHorizBlue,
            tooltip: AppStrings.folderProcesses,
            onSelected: (action) {
              switch (action) {
                case _FolderAction.rename:
                  renameDialog(
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
                        ? AppIcons.renameBlue
                        : AppIcons.rename,
                    title: Text(AppStrings.renameFolderText),
                  ),
                ),
                PopupMenuItem(
                  value: _FolderAction.favorite,
                  child: ListTile(
                    leading: isFavoriteFolder
                        ? AppIcons.star(context)
                        : Theme.of(context).brightness == Brightness.light
                        ? AppIcons.starBorder(context)
                        : AppIcons.starBorderBlue(context),
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
