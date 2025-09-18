import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/buttons/selectRootFolder_dropdown.dart';

class MoveFileAlert extends StatelessWidget {
  const MoveFileAlert({super.key, required this.items});

  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Move file'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Please select the target folder"),
          const SizedBox(height: 8),
          SelectRootFolderDropDownButton(items: items),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancelText),
        ),
        Builder(
          builder: (context) {
            final state = context.watch<HomeCubit>().state;
            final canConfirm = state.selectedFolder.isNotEmpty;
            return TextButton(
              onPressed: canConfirm
                  ? () async {
                      Navigator.of(context).pop();
                      await context.read<HomeCubit>().moveSelectedFile();
                    }
                  : null,
              child: const Text('Move'),
            );
          },
        ),
      ],
    );
  }
}
