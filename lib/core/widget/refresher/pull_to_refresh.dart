import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/blue_body.dart';

class PulRefresh extends StatelessWidget {
  const PulRefresh({
    super.key,
    required this.isGrid,
    required this.scrollController,
  });

  final bool isGrid;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.bgSmoothDark
          : AppColors.bgPrimary,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.bgSecondary
          : AppColors.bgTriartry,
      onRefresh: () {
        context.read<HomeCubit>().handleRefresh();
        return Future.value();
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: AppPaddings.small),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: HomePageBlueBody(isGrid: isGrid)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
