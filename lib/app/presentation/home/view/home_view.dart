import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/view/favorite_view.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summary_data.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summary_header.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_white_body.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/view/profile_view.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_cubit.dart';
import 'package:neonappscase_gradproject/core/network/cubit/network_state.dart';
import 'package:neonappscase_gradproject/core/widget/appBar/custom_appbar.dart';
import 'package:neonappscase_gradproject/core/widget/fab/action_fab.dart';
import 'package:neonappscase_gradproject/core/widget/fab/expandable_fab.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),

      body: BlocListener<NetworkCubit, NetworkState>(
        listenWhen: (prev, next) => prev.status != next.status,
        listener: (ctx, state) {
          final messenger = ScaffoldMessenger.of(ctx);
          final isOnline = state.isOnline;

          messenger.hideCurrentMaterialBanner();
          messenger.showMaterialBanner(
            MaterialBanner(
              backgroundColor: isOnline ? AppColors.success : AppColors.fail,
              leading: Icon(
                isOnline ? Icons.wifi : Icons.wifi_off,
                color: Colors.white,
              ),
              content: Text(
                isOnline ? 'İnternet geri geldi' : 'İnternet bağlantısı yok',
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => messenger.hideCurrentMaterialBanner(),
                  child: const Text(
                    'Kapat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );

          Future.delayed(Duration(seconds: isOnline ? 2 : 4), () {
            if (ctx.mounted) messenger.hideCurrentMaterialBanner();
          });
        },

        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final selected = state.selectedIndex;

            return IndexedStack(
              index: selected,
              children: const [_HomeTab(), FavoriteView(), ProfileView()],
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ExpandableFab(
        distance: 120,
        children: [
          ActionFab(
            icon: Icons.create_new_folder,
            onPressed: () {
              // TODO: klasör oluştur
            },
          ),
          ActionFab(
            icon: Icons.image,
            onPressed: () => context.router.push(const UploadRoute()),
          ),
          ActionFab(
            icon: Icons.upload_file,
            onPressed: () => context.router.push(const UploadFileRoute()),
          ),
        ],
      ),

      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, n) => p.selectedIndex != n.selectedIndex,
        builder: (context, state) {
          return CurvedNavigationBar(
            // bazı sürümlerde programatik index güncellemesi için:
            key: ValueKey(state.selectedIndex),
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.bgSecondary
                : AppColors.bgPrimary,
            backgroundColor: AppColors.bgTriartry,
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.star, size: 30),
              Icon(Icons.person, size: 30),
            ],
            index: state.selectedIndex,
            onTap: (i) => context.read<HomeCubit>().setSelectedIndex(i),
          );
        },
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final state = context.select((HomeCubit c) => c.state);

    return LiquidPullToRefresh(
      color: AppColors.bgPrimary,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.bgSecondary
          : AppColors.bgTriartry,
      onRefresh: () {
        context.read<HomeCubit>().handleRefresh();
        return Future.value();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: HomePageBody(
          isGrid: state.isGridView,
          acountData: state.acountInfos ?? {},
        ),
      ),
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
  final Map<String, dynamic> acountData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomePageSummmaryData(acountInfos: acountData)
            .withPadding(
              EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
            )
            .withPadding(
              EdgeInsets.only(top: AppMediaQuery.screenWidth(context) * 0.12),
            ),
        HomePageSummaryHeader(accountInfos: acountData),

        SizedBox(
          height: AppMediaQuery.screenHeight(context) * 0.8,
          width: AppMediaQuery.screenWidth(context),
          child: DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.25,
            maxChildSize: 0.98,
            snap: true,
            snapSizes: const [0.28, 0.60, 0.92],
            builder: (ctx, scrollController) {
              final theme = Theme.of(ctx);
              return Container(
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? Colors.grey.shade900
                      : Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
