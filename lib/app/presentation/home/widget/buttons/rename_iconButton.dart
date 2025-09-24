import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/renameFolder_dialog.dart';

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
        RenameDialog(context, folderNameController, folder);
      },
      icon: color == AppColors.bgTriartry
          ? AppIcons.rename_blue
          : AppIcons.rename,
    );
  }
}
