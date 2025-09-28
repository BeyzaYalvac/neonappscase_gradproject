// lib/app/presentation/home/cubit/home_state.dart

import 'package:equatable/equatable.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isGridView;

  /// 0: Folders, 1: Files, 2: Images
  final int selectedIndex;

  final AccountModel? acountInfos;

  final int currentFldId;
  final List<int> breadcrumbFldIds;

  final List<FileFolderListModel> allFolders; //bütün klasörlerrr
  final String selectedFolder;
  final List<FileFolderListModel> folders; // filtrelenmiş klasörler
  final List<FileItem> files;
  final List<FileItem> images;

  /// Arama sorgularım
  final String qsearch;

  final int imagesPage;
  final bool imagesHasMore;
  final bool isLoadingMore;

  const HomeState({
    this.isLoading = false,
    this.isGridView = false,
    this.selectedIndex = 0,
    this.acountInfos,
    this.currentFldId = 0,
    this.breadcrumbFldIds = const [0],
    this.folders = const [],
    this.files = const [],
    this.images = const [],
    this.qsearch = '',
    this.allFolders = const [],
    this.selectedFolder = '',
    this.imagesPage = 1,
    this.imagesHasMore = true,
    this.isLoadingMore = false,
  });

  factory HomeState.initial() => const HomeState();

  HomeState copyWith({
    bool? isLoading,
    bool? isGridView,
    int? selectedIndex,
    AccountModel? acountInfos,
    int? currentFldId,
    List<int>? breadcrumbFldIds,
    List<FileFolderListModel>? folders,
    List<FileItem>? files,
    List<FileFolderListModel>? allFolders,
    String? selectedFolder,
    List<FileItem>? images,
    String? qsearch,
    int? imagesPage,
    bool? imagesHasMore,
    bool? isLoadingMore,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      acountInfos: acountInfos ?? this.acountInfos,
      currentFldId: currentFldId ?? this.currentFldId,
      breadcrumbFldIds: breadcrumbFldIds ?? this.breadcrumbFldIds,
      folders: folders ?? this.folders,
      files: files ?? this.files,
      allFolders: allFolders ?? this.allFolders,
      selectedFolder: selectedFolder ?? this.selectedFolder,
      images: images ?? this.images,
      qsearch: qsearch ?? this.qsearch,
      imagesPage: imagesPage ?? this.imagesPage,
      imagesHasMore: imagesHasMore ?? this.imagesHasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isGridView,
    selectedIndex,
    acountInfos,
    currentFldId,
    breadcrumbFldIds,
    folders,
    allFolders,
    files,
    images,
    qsearch,
    selectedFolder,
    imagesPage,
    imagesHasMore,
    isLoadingMore,
  ];
}
