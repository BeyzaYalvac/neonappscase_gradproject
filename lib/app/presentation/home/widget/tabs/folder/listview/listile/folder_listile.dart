import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/rename_iconButton.dart';

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
              RenameIconButton(
                folderNameController: folderNameController,
                folder: filteredFolders[index],
              ),
              IconButton(
                icon: isFavoriteFolder ? AppIcons.star : AppIcons.star_border,

                color: AppColors.bgTriartry,
                onPressed: () {
                  if (isFavoriteFolder) {
                    cubit.removeFavoriteFolder(filteredFolders[index].fldId);
                  } else {
                    cubit.addFavoriteFolder(filteredFolders[index]);
                  }
                },
              ),
              AppIcons.folder,
            ],
          ),
          title: Text(
            filteredFolders[index].name,
            style: TextStyle(
              color: AppColors.bgTriartry,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
