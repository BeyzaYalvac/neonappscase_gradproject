import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class SelectRootFolderDropDownButton extends StatelessWidget {
  const SelectRootFolderDropDownButton({
    super.key,
    required this.items,
  });

  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final safeValue = items.any((e) => e.value == state.selectedFolder)
            ? state.selectedFolder
            : null;

        return DropdownButton<String>(
          dropdownColor: AppColors.bgQuaternary,
          style: const TextStyle(color: AppColors.textWhite),
          elevation: 6,
          isExpanded: true,
          value: safeValue,
          hint: const Text(AppStrings.selectText),
          items: items,
          onChanged: items.isEmpty
              ? null
              : (String? id) {
                  if (id == null) return;
                  context.read<HomeCubit>().setSelectedFolder(id);
                },
        );
      },
    );
  }
}
