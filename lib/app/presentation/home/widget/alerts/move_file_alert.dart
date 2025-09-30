import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/select_any_folder_dropdown.dart';

class MoveFileAlert extends StatelessWidget {
  const MoveFileAlert({super.key, required this.items, required this.file});

  final List<DropdownMenuItem<String>> items;
  final FileItem file;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.moveFileText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(AppStrings.folderChooseText),
          const SizedBox(height: AppPaddings.small),
          SelectAnyFolderDropDownButton(items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancelText),
        ),

        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final selectedStr = state.selectedFolder;
            final selectedId = int.tryParse(selectedStr);
            final canMove = selectedId != null && selectedId > 0;

            return TextButton(
              onPressed: !canMove
                  ? null
                  : () async {
                      final targetFldId = selectedId;

                      if ((file.fileCode).toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.noFileCodeText),
                          ),
                        );
                        return;
                      }

                     
                        await context.read<HomeCubit>().moveFileToFolders(
                          file.fileCode,
                          targetFldId,
                        );
                        if (context.mounted) Navigator.of(context).pop();
                      
                    },
              child: const Text(AppStrings.moveFileText),
            );
          },
        ),
      ],
    );
  }
}
