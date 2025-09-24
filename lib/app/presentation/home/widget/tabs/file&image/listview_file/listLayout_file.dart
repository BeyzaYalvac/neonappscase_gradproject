import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/moveFile_dialog.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_file/listile_file/file_listile.dart';

class HomePageListLayoutTabFile extends StatelessWidget {
  final List<FileItem> filteredFiles;

  const HomePageListLayoutTabFile({super.key, required this.filteredFiles});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.screenWidth(context) * 0.05,
          ),
          itemCount: filteredFiles.length,
          itemBuilder: (context, index) {
            // Dosyanın favori olup olmadığını kontrol et
            final key = filteredFiles[index].link;
            final box = Hive.box('favorite_box');
            final isFavoriteFile = box.values.any(
              (v) => v is Map && v['type'] == 'file' && v['id'] == key,
            );

            return FileListile(isFavoriteFile: isFavoriteFile, cubit: cubit, filteredFiles: filteredFiles,index:index);
          },
        );
      },
    );
  }
}

