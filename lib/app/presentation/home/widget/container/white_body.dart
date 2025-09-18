import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/searchbars/custom_searchBar.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listLayout_file.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/listLayout_image.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/gridview/folder_gridview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/listview/folder_listview.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/gridLayout_file_.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/sections_tabs.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/gridToggle_tabs.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class HomePageWhiteBody extends StatefulWidget {
  const HomePageWhiteBody({super.key, required this.isGrid});
  final bool isGrid;

  @override
  State<HomePageWhiteBody> createState() => _HomePageWhiteBodyState();
}

class _HomePageWhiteBodyState extends State<HomePageWhiteBody> {
  final TextEditingController _searchController = TextEditingController();

  bool _tabListenerAttached = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Aktif tab'ın query'sini oku (TabController ile)
        String _currentQueryOf(TabController tab) {
          switch (tab.index) {
            case 0:
              return state.qFolder;
            case 1:
              return state.qFile;
            default:
              return state.qFile;
          }
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.bgPrimary
                : Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: DefaultTabController(
            length: 3,
            child: Builder(
              builder: (context) {
                final TabController tab = DefaultTabController.of(context);

                if (!_tabListenerAttached) {
                  _tabListenerAttached = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _searchController.text = _currentQueryOf(tab);
                    _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _searchController.text.length),
                    );
                  });

                  tab.addListener(() {
                    if (tab.indexIsChanging) return;
                    final cubit = context.read<HomeCubit>();
                    final s = cubit.state;
                    final text = tab.index == 0 ? s.qFolder : s.qFile;
                    _searchController.text = text;
                    _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: text.length),
                    );
                    if (tab.index == 1) cubit.loadFiles();
                    if (tab.index == 0) cubit.loadFolders();
                  });
                }

                return Column(
                  children: [
                    AppPaddings.CustomHeightSizedBox(context, 0.02),
                    Row(
                      children: [
                        Text(
                              AppStrings.recentFilesText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 20,
                              ),
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
                        final tabIndex = DefaultTabController.of(
                          context,
                        ).index;
                        context.read<HomeCubit>().setSearchQueryForTab(
                          tabIndex,
                          v,
                        );
                      },
                      onClear: () {
                        final tabIndex = DefaultTabController.of(context).index;
                        context.read<HomeCubit>().clearSearch(tabIndex);
                        _searchController.clear();
                      },
                    ),
                    SizedBox(
                      height: AppMediaQuery.screenHeight(context) * 0.5,
                      child: TabBarView(
                        children: [
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
