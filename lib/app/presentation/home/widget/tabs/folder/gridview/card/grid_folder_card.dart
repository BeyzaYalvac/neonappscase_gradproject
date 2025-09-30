import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/favorite_icon_button.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/rename_icon_button.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/folder_icon_container.dart';
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
          shadowColor: AppColors.bgSmoothLight,
          child: Stack(
            children: [
              FolderIconContainer(),

              Container(
                color: AppColors.bgTransparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPaddings.customHeightSizedBox(context, 0.072),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (prev, next) =>
                          prev.folders != next.folders ||
                          prev.allFolders != next.allFolders,
                      builder: (context, state) {
                        final idx = state.allFolders.indexWhere(
                          (f) => f.fldId.toString() == folder.fldId.toString(),
                        );
                        final updated = idx == -1
                            ? folder
                            : state.allFolders[idx];
                        return Text(
                          updated.name,
                          style: AppTextSytlyes.profileStatusBoldTextStyle,
                        ).withAlignment(Alignment.center);
                      },
                    ),
                  ],
                ).withPadding(const EdgeInsets.fromLTRB(8, 4, 8, 8)),
              ),

              FavoriteIconButton(
                    isFavoriteFolder: isFavoriteFolder,
                    cubit: cubit,
                    folder: folder,
                  )
                  .withPadding(const EdgeInsets.fromLTRB(0, 0, 8, 0))
                  .withAlignment(Alignment.topLeft),

              RenameIconButton(
                folderNameController: folderNameController,
                folder: folder,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.bgTriartry
                    : AppColors.bgPrimary,
              ).withAlignment(Alignment.topRight),
            ],
          ),
        );
      },
    );
  }
}
