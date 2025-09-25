import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_image/listile_image/imageactions_dropdown.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class ImageListile extends StatelessWidget {
  const ImageListile({
    super.key,
    required this.isFavoriteImage,
    required this.favCubit,
    required this.fileKey,
    required this.item,
    required this.index,
  });

  final bool isFavoriteImage;
  final FavoriteCubit favCubit;
  final String fileKey;
  final FileItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return ListTile(
          leading: AppIcons.file(context),
          title: Text(
            item.name,
            style: AppTextSytlyes.fileNameTextStyle(context),
          ),
          trailing: ImageactionsDropdown(
            filteredImage: item,
            index: index,
            isFavoriteFile: state.isFavorite,
            cubit: cubit,
          ),
        ).withPadding(EdgeInsetsGeometry.all(8));
      },
    );
  }
}
