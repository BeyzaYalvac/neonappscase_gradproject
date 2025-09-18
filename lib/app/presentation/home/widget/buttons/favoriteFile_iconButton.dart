import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';

class FavoriteFileIconButton extends StatelessWidget {
  const FavoriteFileIconButton({
    super.key,
    required this.isFavoriteFile,
    required this.cubit,
    required this.file,
  });

  final bool isFavoriteFile;
  final FavoriteCubit cubit;
  final FileItem file;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFavoriteFile ? AppIcons.star : AppIcons.star_border,
      color: AppColors.bgTriartry,
      onPressed: () {
        if (isFavoriteFile) {
          cubit.removeFavoriteFileByKey(file.link);
        } else {
          cubit.addFavoriteFile(file);
        }
      },
    );
  }
}
