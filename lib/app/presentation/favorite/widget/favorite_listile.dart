import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';

class FavoriteListile extends StatelessWidget {
  const FavoriteListile({
    super.key,
    required this.isFolder,
    required this.name,
    required this.fav,
  });

  final bool isFolder;
  final String name;
  final Map fav;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        (isFolder ? AppIcons.folder : AppIcons.file(context)) as IconData?,
        color:
            Theme.of(context).brightness ==
                Brightness.light
            ? AppColors.bgTriartry
            : AppColors.bgPrimary,
      ),
      title: Text(name),
      trailing: IconButton(
        icon: AppIcons.delete,
        onPressed: () {
          // fldId ile silmek istersemmm:
          if (fav['id'] != null &&
              fav['type'] == 'folder') {
            context
                .read<FavoriteCubit>()
                .removeFavoriteFolder(fav['id']);
          } else if (fav['type'] == 'file' &&
              fav['id'] != null) {
            context
                .read<FavoriteCubit>()
                .removeFavoriteFileByKey(fav['id']);
          } else if (fav['type'] == 'image' &&
              fav['id'] != null) {
            context
                .read<FavoriteCubit>()
                .removeFavoriteImage(fav['id']);
          }
        },
      ),
    );
  }
}
