import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/blue_body_header.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/searchbars/custom_searchbar.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/bloe_body_content_tabs.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/sections_tabs.dart';

class HomePageBlueBody extends StatefulWidget {
  const HomePageBlueBody({super.key, required this.isGrid});
  final bool isGrid;

  @override
  State<HomePageBlueBody> createState() => _HomePageBlueBodyState();
}

class _HomePageBlueBodyState extends State<HomePageBlueBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchBarOnClear(BuildContext context) {
    final uiIndex = DefaultTabController.of(context).index;
    final eff = context.read<HomeCubit>().uiToCubit(uiIndex);
    context.read<HomeCubit>().clearSearch(eff);
    _searchController.clear();
  }

  void _onTabChanged() {
    final tab = DefaultTabController.of(context);
    if (!tab.indexIsChanging) {
      context.read<HomeCubit>().onTabChanged(tab.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final tab = DefaultTabController.of(context);

          // 2) Search text'i state.qsearch ile senkronla (yalnız değiştiyse)
          if (_searchController.text != state.qsearch) {
            searhStateSenchron(state);
          }

          // 3) Listener’ı güvenli kur: önce kaldır, sonra ekle
          tab.removeListener(_onTabChanged);
          tab.addListener(_onTabChanged);

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.bgTriartry
                  : Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                AppPaddings.customHeightSizedBox(context, 0.02),
                BlueBodyHeader(),
                const HomePageSectionTabs(),
                BlueSearchBar(
                  controller: _searchController,
                  onChanged: (v) {
                    context.read<HomeCubit>().searchBarOnChanged(context, v);
                  },
                  onClear: () {
                    searchBarOnClear(context);
                  },
                ),
                BlueBodyContentTab(widget: widget, state: state),
              ],
            ),
          );
        },
      ),
    );
  }

  void searhStateSenchron(HomeState state) {
    _searchController.text = state.qsearch;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: _searchController.text.length),
    );
  }
}
