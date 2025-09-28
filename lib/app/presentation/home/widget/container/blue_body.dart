import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/searchbars/custom_searchbar.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_file/listlayout_file.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listview_image/listlayout_image.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/gridview/folder_gridview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/listview/folder_listview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/gridview%20file_image/file_gridlayout.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/sections_tabs.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/gridtoggle_tabs.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/tabs%20sections/all_items_tab.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class HomePageWhiteBody extends StatefulWidget {
  const HomePageWhiteBody({super.key, required this.isGrid});
  final bool isGrid;

  @override
  State<HomePageWhiteBody> createState() => _HomePageWhiteBodyState();
}

class _HomePageWhiteBodyState extends State<HomePageWhiteBody> {
  final TextEditingController _searchController = TextEditingController();

  int _uiToCubit(int ui) => ui == 0 ? 3 : ui - 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    final tab = DefaultTabController.of(context);
    if (tab.indexIsChanging) return;
    context.read<HomeCubit>().applyFilterForTab(_uiToCubit(tab.index));
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
            _searchController.text = state.qsearch;
            _searchController.selection = TextSelection.fromPosition(
              TextPosition(offset: _searchController.text.length),
            );
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
                Row(
                  children: [
                    Text(
                          AppStrings.recentFilesText,
                          style: AppTextSytlyes.recentFileTextStyle(context)
                        )
                        .withAlignment(Alignment.centerLeft)
                        .withPadding(
                          EdgeInsets.symmetric(
                            horizontal:
                                AppMediaQuery.screenWidth(context) * 0.05,
                          ),
                        ),
                    const GridToggleTabs(),
                  ],
                ),
                const HomePageSectionTabs(),
                BlueSearchBar(
                  controller: _searchController,
                  onChanged: (v) {
                    final uiIndex = DefaultTabController.of(context).index;
                    final eff = _uiToCubit(uiIndex); // All(0)->3, diğerleri -1
                    context.read<HomeCubit>().setSearchQueryForTab(eff, v);
                  },
                  onClear: () {
                    final uiIndex = DefaultTabController.of(context).index;
                    final eff = _uiToCubit(uiIndex);
                    context.read<HomeCubit>().clearSearch(eff);
                    _searchController.clear();
                  },
                ),
                SizedBox(
                  height: AppMediaQuery.screenHeight(context) * 0.5,
                  child: TabBarView(
                    children: [
                      AllItemsBody(isGrid: widget.isGrid, state: state),

                      widget.isGrid
                          ? HomePageFolderGridLayoutTabFolder(
                              filteredFolders: state.folders,
                            )
                          : HomePageFolderListLayoutTabFolder(
                              filteredFolders: state.folders,
                            ),
                      widget.isGrid
                          ? HomePageGridLayoutTabFileImage(
                              filteredItems: state.files,
                            )
                          : HomePageListLayoutTabFile(
                              filteredFiles: state.files,
                            ),
                      widget.isGrid
                          ? HomePageGridLayoutTabFileImage(
                              filteredItems: state.images,
                            )
                          : HomePageListLayoutTabImage(
                              filteredImages: state.images,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
