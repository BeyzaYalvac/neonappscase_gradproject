import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/rename_folder_dialog.dart';

class RenameIconButton extends StatelessWidget {
  final Color color;
  const RenameIconButton({
    super.key,
    required this.folderNameController,
    required this.folder,
    required this.color,
  });

  final TextEditingController folderNameController;
  final FileFolderListModel folder;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        renameDialog(context, folderNameController, folder);
      },
      icon: color == AppColors.bgTriartry
          ? AppIcons.renameBlue
          : AppIcons.rename,
    );
  }
}
