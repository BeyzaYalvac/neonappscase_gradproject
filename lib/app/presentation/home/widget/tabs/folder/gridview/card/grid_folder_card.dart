import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/favoriteFolder_iconButton.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/rename_iconButton.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/folderIcon_container.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class GridFolderCard extends StatelessWidget {
  final FileFolderListModel folder;
  const GridFolderCard({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    final TextEditingController folderNameController = TextEditingController(
      text: folder.name,
    );
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();
        final isFavoriteFolder = state.favoriteFolders.any(
          (fav) => fav['id'] == folder.fldId && fav['type'] == 'folder',
        );
        return Card(
          borderOnForeground: true,
          elevation: 5,
          shadowColor: AppColors.bgTriartry,
          child: Stack(
            children: [
              FolderIconContainer(),

              Container(
                color: AppColors.bgTransparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPaddings.CustomHeightSizedBox(context, 0.072),
                    // İsim kısmındaki BlocBuilder'da ŞUNU KULLAN:
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (prev, next) =>
                          prev.folders != next.folders ||
                          prev.allFolders !=
                              next.allFolders, // 👈 allFolders’ı da dinle
                      builder: (context, state) {
                        final idx = state.allFolders.indexWhere(
                          (f) => f.fldId.toString() == folder.fldId.toString(),
                        );
                        final updated = idx == -1
                            ? folder
                            : state.allFolders[idx];
                        return Text(
                          updated.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                    ),

                    Text('Modified: 15 days ago'),
                  ],
                ).withPadding(const EdgeInsets.fromLTRB(8, 4, 8, 1)),
              ),

              FavoriteIconButton(isFavoriteFolder: isFavoriteFolder, cubit: cubit, folder: folder)
                  .withPadding(const EdgeInsets.fromLTRB(0, 0, 8, 0))
                  .withAlignment(Alignment.topLeft),

              RenameIconButton(folderNameController: folderNameController, folder: folder).withAlignment(Alignment.topRight),
            ],
          ),
        );
      },
    );
  }

  }



