import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/moveFile_dialog.dart';

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
    final state = context.read<FavoriteCubit>().state;
    final cubit = context.read<FavoriteCubit>();
    final key = filteredImage.link;
    final box = Hive.box('favorite_box');
    final isFavoriteImage = cubit.isFavoriteImage(key);
    return PopupMenuButton<_fileAction>(
      icon: Theme.of(context).brightness == Brightness.light
          ? AppIcons.more_horiz
          : AppIcons.more_horiz_blue,
      tooltip: AppStrings.fileProcesses,
      onSelected: (action) {
        switch (action) {
          case _fileAction.move:
            final state = context.read<HomeCubit>().state;
            MoveFileDialog(context, state, filteredImage);
            break;

          case _fileAction.favorite:
            final key = filteredImage.link;
            final isFavoriteFile = cubit.isFavoriteImage(key);
            if (isFavoriteFile) {
              cubit.removeFavoriteImage(key);
            } else {
              cubit.addFavoriteImages(filteredImage);
            }
            break;
          case _fileAction.download:
            context.read<HomeCubit>().downloadFile(filteredImage.link);
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
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return ListTile(
                  leading: isFavoriteImage
                      ? AppIcons.star(context)
                      : Theme.of(context).brightness == Brightness.light
                      ? AppIcons.star_border(context)
                      : AppIcons.star_border_blue(context),
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
