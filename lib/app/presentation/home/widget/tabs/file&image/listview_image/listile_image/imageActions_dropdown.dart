import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/move_file_dialog.dart';

class ImageactionsDropdown extends StatelessWidget {
  const ImageactionsDropdown({
    super.key,
    required this.filteredImage,
    required this.index,
    required this.isFavoriteFile,
    required this.cubit,
  });

  final FileItem filteredImage;
  final int index;
  final bool isFavoriteFile;
  final FavoriteCubit cubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();
    final key = filteredImage.link;
    Hive.box('favorite_box');
    final isFavoriteImage = cubit.isFavoriteImage(key);
    return PopupMenuButton<FileActions>(
      icon: Theme.of(context).brightness == Brightness.light
          ? AppIcons.moreHoriz
          : AppIcons.moreHorizBlue,
      tooltip: AppStrings.fileProcesses,
      onSelected: (action) {
        switch (action) {
          case FileActions.move:
            final state = context.read<HomeCubit>().state;
            moveFileDialog(context, state, filteredImage);
            break;

          case FileActions.favorite:
            final key = filteredImage.link;
            final isFavoriteFile = cubit.isFavoriteImage(key);
            if (isFavoriteFile) {
              cubit.removeFavoriteImage(key);
            } else {
              cubit.addFavoriteImages(filteredImage);
            }
            break;
          case FileActions.download:
            context.read<HomeCubit>().downloadFile(filteredImage.link);
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
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return ListTile(
                  leading: isFavoriteImage
                      ? AppIcons.star(context)
                      : Theme.of(context).brightness == Brightness.light
                      ? AppIcons.starBorder(context)
                      : AppIcons.starBorderBlue(context),
                  title: Text(
                    isFavoriteImage
                        ? AppStrings.removeFavorites
                        : AppStrings.addFavorites,
                  ),
                );
              },
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
