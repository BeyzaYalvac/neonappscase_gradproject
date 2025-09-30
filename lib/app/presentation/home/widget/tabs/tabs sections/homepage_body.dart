import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/blue_body.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summarydata.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summaryheader.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';
import 'package:neonappscase_gradproject/core/widget/refresher/pull_to_refresh.dart';

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
                    ? AppColors.bgSecondary
                    : AppColors.bgTriartry,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: AppPaddings.medium,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: PulRefresh(isGrid: isGrid, scrollController: scrollController),
            );
          },
        ),
      ],
    );
  }
}

