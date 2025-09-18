import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/selectRootFolder_dropdown.dart';

class CreateFolderAlert extends StatelessWidget {
  final state;
  const CreateFolderAlert({
    super.key,
    required TextEditingController folderNameController,
    required this.current,
    required this.items,
    this.state,
  }) : _folderNameController = folderNameController;

  final TextEditingController _folderNameController;
  final String? current;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.createFolderText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(AppStrings.selectFolderNameText),
          TextField(
            decoration: const InputDecoration(
              hintText: AppStrings.selectFolderNameHintText,
            ),
            controller: _folderNameController,
          ),
          SelectRootFolderDropDownButton( items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancelText),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            context.read<HomeCubit>().addFolder(_folderNameController.text);
            _folderNameController.clear();
          },
          child: const Text(AppStrings.createText),
        ),
      ],
    );
  }
}
