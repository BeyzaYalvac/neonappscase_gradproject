import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class CurvedBottomNavBar extends StatelessWidget {
  const CurvedBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (p, n) => p.selectedIndex != n.selectedIndex,
      builder: (context, state) {
        return CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          //key: ValueKey(state.selectedIndex),
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgSmoothDark
              : AppColors.bgPrimary,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgSecondary
              : AppColors.bgTriartry,
          items: [AppIcons.home, AppIcons.favorite, AppIcons.profile],
          index: state.selectedIndex,
          onTap: (i) => context.read<HomeCubit>().setSelectedIndex(i),
        );
      },
    );
  }
}
