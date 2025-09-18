import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';

Future<dynamic> RenameDialog(
  BuildContext context,
  TextEditingController folderNameController,
  FileFolderListModel folder,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Rename Folder'),
        content: TextField(
          controller: folderNameController,
          decoration: InputDecoration(
            label: Text("Enter your new folder name"),
            hintText: "Enter new folder name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().renameFolder(
                folder.fldId,
                folderNameController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text('Rename'),
          ),
        ],
      );
    },
  );
}
