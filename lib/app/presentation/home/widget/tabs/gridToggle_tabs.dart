import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';

class GridToggleTabs extends StatelessWidget {
  const GridToggleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: TabBar(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.screenWidth(context) / 8,
            vertical: 8,
          ),
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: AppColors.textWhite,
          unselectedLabelColor: AppColors.bgQuaternary,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.bgTriartry,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          tabs: [
            Tab(icon: AppIcons.list),
            Tab(icon: AppIcons.grid),
          ],
          onTap: (index) {
            final cubit = context.read<HomeCubit>();
            if (index == 0) {
              cubit.setGridView(false);
            } else if (index == 1) {
              cubit.setGridView(true);
            }
          },
        ),
      ),
    );
  }
}
