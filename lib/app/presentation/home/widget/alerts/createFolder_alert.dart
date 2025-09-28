import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/selectRootFolder_dropdown.dart';

class CreateFolderAlert extends StatelessWidget {
  final HomeState state;
  const CreateFolderAlert({
    super.key,
    required TextEditingController folderNameController,
    required this.current,
    required this.items,
    required this.state,
  }) : _folderNameController = folderNameController;

  final TextEditingController _folderNameController;
  final String? current;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: Border.all(color: AppColors.bgQuaternary, width: 2),
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
          SelectRootFolderDropDownButton(items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppStrings.cancelText,
            style: AppTextSytlyes().cancelTextStyle(context),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            context.read<HomeCubit>().addFolder(_folderNameController.text);
            _folderNameController.clear();
          },
          child: Text(
            AppStrings.createText,
            style: AppTextSytlyes().boldTextStyle(),
          ),
        ),
      ],
    );
  }
}
