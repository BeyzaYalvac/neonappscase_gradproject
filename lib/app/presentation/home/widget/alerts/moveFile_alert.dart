import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/selectRootFolder_dropdown.dart';

class MoveFileAlert extends StatelessWidget {
  const MoveFileAlert({super.key, required this.items, required this.file});

  final List<DropdownMenuItem<String>> items;
  final FileItem file;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Move File'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Which folder do you want to move this file to?'),
          const SizedBox(height: 8),
          SelectRootFolderDropDownButton(items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
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
                          const SnackBar(content: Text('fileCode yok')),
                        );
                        return;
                      }

                      try {
                        await context.read<HomeCubit>().moveFileToFolders(
                          file.fileCode,
                          targetFldId,
                        );
                        if (context.mounted) Navigator.of(context).pop();
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Move failed: $e')),
                        );
                      }
                    },
              child: const Text('Move'),
            );
          },
        ),
      ],
    );
  }
}
