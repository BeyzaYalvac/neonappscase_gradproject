import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_file/listile_file/fileactions_dropdown.dart';

class FileListile extends StatelessWidget {
  final int index;
  const FileListile({
    super.key,
    required this.isFavoriteFile,
    required this.cubit,
    required this.filteredFiles,
    required this.index,
  });

  final bool isFavoriteFile;
  final FavoriteCubit cubit;
  final List<FileItem> filteredFiles;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIcons.file(context),
      title: Text(
        filteredFiles[index].name,
        style: AppTextSytlyes.fileNameTextStyle(context),
      ),
      subtitle: Text(
        'Size: ${index * 10 + 5} MB',
        style: AppTextSytlyes.fileTileTextStyle(context),
      ),
      trailing: FileActionsPopUpMenu(filteredFiles: filteredFiles, index: index, isFavoriteFile: isFavoriteFile, cubit: cubit),
    );
  }
}
