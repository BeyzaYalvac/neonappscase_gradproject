import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isFavoriteFolder,
    required this.cubit,
    required this.folder,
  });

  final bool isFavoriteFolder;
  final FavoriteCubit cubit;
  final FileFolderListModel folder;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFavoriteFolder
          ? AppIcons.star(context)
          : AppIcons.star_border(context),
      color: AppColors.bgTriartry,
      onPressed: () {
        if (isFavoriteFolder) {
          cubit.removeFavoriteFolder(folder.fldId);
        } else {
          cubit.addFavoriteFolder(folder);
        }
      },
    );
  }
}
