import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summary_data.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summary_header.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/white_body.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class HomeTab extends StatelessWidget {
  const HomeTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final account = state.acountInfos;
        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textBej),
          );
        }
        return HomePageBody(isGrid: state.isGridView, acountData: account);
      },
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
    required this.isGrid,
    required this.acountData,
  });
  final bool isGrid;
  final AccountModel acountData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomePageSummaryHeader(accountInfos: acountData),
        Positioned(
          top: AppMediaQuery.screenHeight(context) * 0.25,
          child: HomePageSummmaryData(acountInfos: acountData)
              .withPadding(
                EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
              )
              .withPadding(
                EdgeInsets.only(top: AppMediaQuery.screenWidth(context) * 0.12),
              ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.55,
          maxChildSize: 0.98,
          snap: true,
          snapSizes: const [0.55, 0.92],
          builder: (ctx, scrollController) {
            final theme = Theme.of(ctx);
            return Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? AppColors.bgSmoothDark
                    : AppColors.bgTriartry,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: LiquidPullToRefresh(
                color: AppColors.bgPrimary,
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
                          const SizedBox(height: 8),
                          Container(
                            width: 42,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: HomePageWhiteBody(isGrid: isGrid),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
