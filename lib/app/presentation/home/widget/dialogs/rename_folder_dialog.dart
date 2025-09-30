import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';

Future<dynamic> renameDialog(
  BuildContext context,
  TextEditingController folderNameController,
  FileFolderListModel folder,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(AppStrings.renameFolderText),
        content: TextField(
          controller: folderNameController,
          decoration: InputDecoration(
            label: Text(AppStrings.enterFolderName),
            hintText: AppStrings.enterFolderName,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppStrings.cancelText),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().renameFolder(
                folder.fldId,
                folderNameController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text(AppStrings.renameText),
          ),
        ],
      );
    },
  );
}
