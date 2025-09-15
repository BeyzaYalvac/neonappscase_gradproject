import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/searchbars/custom_searchBar.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homepage_listLayout_file.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homepage_listLayout_image.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/homepage_gridLayout_folder.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/folder/folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/file&image/homePage_gridLayout_file_build.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/homePage_sections_tab.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/homepage_grid_toggleTabs.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class HomePageWhiteBody extends StatefulWidget {
  const HomePageWhiteBody({super.key, required this.isGrid});
  final bool isGrid;

  @override
  State<HomePageWhiteBody> createState() => _HomePageWhiteBodyState();
}

class _HomePageWhiteBodyState extends State<HomePageWhiteBody> {
  final TextEditingController _searchController = TextEditingController();
  TabController? _activeTab; // 🔵 son bağladığın controller

  bool _tabListenerAttached = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_activeTab == null || _activeTab!.indexIsChanging) return;

    final cubit = context.read<HomeCubit>();
    cubit.setSelectedIndex(_activeTab!.index);

    final s = cubit.state;
    final txt = _activeTab!.index == 0
        ? s.qFolder
        : _activeTab!.index == 1
        ? s.qFile
        : s.qFile;
    if (_searchController.text != txt) {
      _searchController.text = txt;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: txt.length),
      );
    }
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

        return Positioned(
          top: AppMediaQuery.screenHeight(context) * 0.35,
          child: Container(
            width: AppMediaQuery.screenWidth(context),
            height: AppMediaQuery.screenHeight(context) * 0.65,
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
                  final TabController tab = DefaultTabController.of(context)!;
                  // Listener'ı sadece 1 kez bağla
                  if (!_tabListenerAttached) {
                    _tabListenerAttached = true;

                    // İlk açılışta aktif tab'ın query'sini input'a yaz
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

  if (tab.index == 1) cubit.loadFiles();    // <-- EKLE
  if (tab.index == 0) cubit.loadFolders();  // (opsiyonel)
});

                  }

                  return Column(
                    children: [
                      AppPaddings.CustomHeightSizedBox(context, 0.02),
                      Row(
                        children: [
                          Text(
                                "Recent Files",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                      20,
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

                      // 🔵 Sadece aktif tab'ın query'sini günceller
                      BlueSearchBar(
                        controller: _searchController,
                        onChanged: (v) {
                          final tabIndex = DefaultTabController.of(
                            context,
                          )!.index;
                          final cubit = context.read<HomeCubit>();
                          cubit.setSearchQueryForTab(tabIndex, v);
                        },
                        onClear: () {
                          final tabIndex = DefaultTabController.of(
                            context,
                          )!.index;
                          final cubit = context.read<HomeCubit>();
                          cubit.clearSearch(tabIndex);

                          _searchController.clear();
                        },
                      ),

                      // TAB İÇERİKLERİ — İLGİLİ QUERY'Yİ GÖNDER
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Tab 1: Folder
                            widget.isGrid
                                ? HomePageFolderGridLayoutTabFolder(
                                    filteredFolders: state.folders,
                                  )
                                : HomePageFolderListLayoutTabFolder(
                                    filteredFolders: state.folders,
                                  ),

                            // Tab 2: File
                            widget.isGrid
                                ? HomePageGridLayoutTabFileImage(
                                    filteredItems: state.files,
                                  )
                                : HomePageListLayoutTabFile(
                                    filteredFiles: state.files,
                                  ),

                            // Tab 3: Image
                            widget.isGrid
                                ? HomePageGridLayoutTabFileImage(
                                    filteredItems: [],
                                  )
                                : HomePageListLayoutTabImage(
                                    filteredImages: [],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
