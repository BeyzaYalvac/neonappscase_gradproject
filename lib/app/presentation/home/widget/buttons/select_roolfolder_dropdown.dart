import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';

class SelectRootFolderDropDownButton extends StatelessWidget {
  final state;
  const SelectRootFolderDropDownButton({
    super.key,
    required this.current,
    this.state,
    required this.items,
  });

  final String? current;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: AppColors.bgQuaternary,
      style: TextStyle(color: AppColors.textWhite),
      elevation: 6,
      isExpanded: true,
      value: current,
      hint: const Text("Seçiniz"),
      items: items,
      onChanged: state.folders.isEmpty
          ? null
          : (String? id) {
              if (id == null) return;
              context.read<HomeCubit>().setSelectedFolder(id);
            },
    );
  }
}
