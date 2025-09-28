import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class SelectAnyFolderDropDownButton extends StatelessWidget {
  const SelectAnyFolderDropDownButton({super.key, required this.items});

  final List<DropdownMenuItem<String>> items;

  static const String createNewFolderId = "0";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final safeValue = items.any((e) => e.value == state.selectedFolder)
            ? state.selectedFolder
            : null;

        final extendedItems = [...items];

        return DropdownButton<String>(
          dropdownColor: AppColors.bgwhiteBlue,
          style: AppTextSytlyes.primaryColorTextStyle,
          elevation: 6,
          isExpanded: true,
          value: safeValue,
          hint: Text(
            AppStrings.selectText,
            style: AppTextSytlyes().selectAnyFolderTextStyle(context)
          ),
          items: extendedItems,
          onChanged: extendedItems.isEmpty
              ? null
              : (String? id) {
                  if (id == null) return;

                  if (id == createNewFolderId) {
                    // burada Cubit'e özel 0 değeri set ediyorsun
                    context.read<HomeCubit>().setSelectedFolder(
                      createNewFolderId,
                    );

                    // ekstra olarak hemen create dialog açabilirsin
                    // showDialog(...);
                  } else {
                    context.read<HomeCubit>().setSelectedFolder(id);
                  }
                },
        );
      },
    );
  }
}
