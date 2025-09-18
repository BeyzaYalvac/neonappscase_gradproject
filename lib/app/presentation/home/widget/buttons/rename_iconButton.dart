import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/renameFolder_dialog.dart';

class RenameIconButton extends StatelessWidget {
  const RenameIconButton({
    super.key,
    required this.folderNameController,
    required this.folder,
  });

  final TextEditingController folderNameController;
  final FileFolderListModel folder;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        RenameDialog(context, folderNameController, folder);
      },
      icon: AppIcons.rename,
    );
  }
}
