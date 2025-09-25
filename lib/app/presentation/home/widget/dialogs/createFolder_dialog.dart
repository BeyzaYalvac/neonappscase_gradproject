import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/alerts/createfolder_alert.dart';

Future<dynamic> createFolderDialog(BuildContext context) {
  TextEditingController folderNameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Items: hepsini String değere normalize et
          final items = state.folders.map((f) {
            final id = f.fldId.toString();
            return DropdownMenuItem<String>(
              value: id,
              child: Text(f.name, overflow: TextOverflow.ellipsis),
            );
          }).toList();

          final current = items.any((e) => e.value == state.selectedFolder)
              ? state.selectedFolder
              : null;

          return CreateFolderAlert(
            folderNameController: folderNameController,
            current: current,
            items: items,
            state: state,
          );
        },
      );
    },
  );
}
