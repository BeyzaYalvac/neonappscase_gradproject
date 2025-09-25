import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/selectRootFolder_dropdown.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';

class UploadFileAlert extends StatelessWidget {
  const UploadFileAlert({
    super.key,
    required this.current,
    required this.items,
  });

  final String? current;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.uploadText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(AppStrings.folderChooseText),
          SelectRootFolderDropDownButton(items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancelText),
        ),
        TextButton(
          onPressed: () async {
            if (items.isEmpty) return;

            // Dropdown seçiminden sonra güncel folderId’yi al
            final selectedId = context.read<HomeCubit>().state.selectedFolder;

            await context.read<UploadCubit>().uploadFile(folderId: selectedId);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.createText),
        ),
      ],
    );
  }
}
