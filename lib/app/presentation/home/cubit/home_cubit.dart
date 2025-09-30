import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCubit extends Cubit<HomeState> {
  static const int _perPage = 5;

  HomeCubit() : super(HomeState.initial()) {
    loadProfileData();
    loadImagesInitial();
    loadFolders();
    loadFiles();
  }
  HomeCubit.forDetail() : super(HomeState.initial().copyWith(isLoading: true));

  Future<void> loadFolders() async {
    emit(state.copyWith(isLoading: true));

    final result = await InjectionContainerItems.contentRepository
        .getFolderList(fldId: state.currentFldId, bustCache: true);
    //debugPrint('-----------$result------------');
    // Ham listeyi saklamak ve aktif qFolder’a göre ekrana yansıtmak
    final filtered = _filterFolders(result, state.qsearch);
    emit(
      state.copyWith(isLoading: false, allFolders: result, folders: filtered),
    );
  }

  Future<void> getFoldersInFolder(int fldId) async {
    emit(state.copyWith(isLoading: true));

    final result = await InjectionContainerItems.contentRepository
        .getFolderList(fldId: fldId);
    emit(state.copyWith(isLoading: false, folders: result));
  }

  List<FileFolderListModel> _filterFolders(
    List<FileFolderListModel> source,
    String query,
  ) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return List<FileFolderListModel>.from(source);
    return source.where((f) => (f.name).toLowerCase().contains(q)).toList();
  }

  List<FileItem> _onlyNonImages(List<FileItem> all) {
    bool nameHas(String s) {
      final n = s.trim().toLowerCase();
      return n.endsWith('.png') || n.endsWith('.jpg') || n.endsWith('.jpeg');
    }

    return all.where((f) => !nameHas(f.name)).toList();
  }

  static const int _filesPerPage = 100; // ihtiyacına göre 50/100/200

  Future<void> loadFiles() async {
    emit(state.copyWith(isLoading: true));

    final all = await InjectionContainerItems.contentRepository.getFileList(
      fldId: state.currentFldId,
      nameFilter: state.qsearch.isEmpty ? null : state.qsearch,
      perPage: _filesPerPage,
    );
    emit(state.copyWith(isLoading: false, files: _onlyNonImages(all)));
  }

  //isim filtreli file çekme
  // isim filtreli file çekme
  Future<void> _fetchFiles(String nameFilter) async {
    emit(state.copyWith(isLoading: true));

    final res = await InjectionContainerItems.contentRepository.getFileList(
      fldId: state.currentFldId,
      nameFilter: nameFilter.isEmpty ? null : nameFilter,
      page: 1,
      perPage: _filesPerPage,
    );
    emit(state.copyWith(isLoading: false, files: _onlyNonImages(res)));
  }

  // 2.1) İlk sayfa (listeyi sıfırla)
  Future<void> loadImagesInitial() async {
    emit(state.copyWith(isLoading: true, imagesPage: 1, imagesHasMore: true));

    final page = 1;
    final all = await InjectionContainerItems.contentRepository.getFileList(
      fldId: state.currentFldId,
      nameFilter: state.qsearch.isEmpty ? null : state.qsearch,
      page: page,
      perPage: _perPage,
    );

    final re = RegExp(r'\.(png|jpe?g)$', caseSensitive: false);
    final images = all.where((f) => re.hasMatch(f.name)).toList();

    emit(
      state.copyWith(
        isLoading: false,
        images: images,
        imagesPage: page,
        imagesHasMore: all.length == _perPage, // < perPage ise bitti
      ),
    );
  }

  // 2.2) Devamını getir (append)
  Future<void> loadMoreImages() async {
    if (state.isLoadingMore || !state.imagesHasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.imagesPage + 1;

    final all = await InjectionContainerItems.contentRepository.getFileList(
      fldId: state.currentFldId,
      nameFilter: state.qsearch.isEmpty ? null : state.qsearch,
      page: nextPage,
      perPage: _perPage,
    );

    final re = RegExp(r'\.(png|jpe?g)$', caseSensitive: false);
    final newImages = all.where((f) => re.hasMatch(f.name)).toList();

    emit(
      state.copyWith(
        isLoadingMore: false,
        images: [...state.images, ...newImages],
        imagesPage: nextPage,
        imagesHasMore: all.length == _perPage,
      ),
    );
  }

  Future<void> loadProfileData() async {
    emit(state.copyWith(isLoading: true));

    final account = await InjectionContainerItems.appAccountRepository
        .fetchAccountDetails();
    emit(state.copyWith(isLoading: false, acountInfos: account));
  }

  Future<List<FileItem>?> getFilesInFolder(int fldId) async {
    emit(state.copyWith(isLoading: true));

    final result = await InjectionContainerItems.contentRepository.getFileList(
      fldId: fldId,
    );
    emit(state.copyWith(isLoading: false, files: result));
    debugPrint(result.toString());
    return result;
  }

  void setGridView(bool value) => emit(state.copyWith(isGridView: value));
  void setSelectedIndex(int index) =>
      emit(state.copyWith(selectedIndex: index));
  void handleRefresh() => loadProfileData();

  void setSearchQueryForTab(int tabIndex, String query) {
    emit(state.copyWith(qsearch: query));

    if (tabIndex == 0) {
      // Folders (client-side)
      final filtered = _filterFolders(state.allFolders, query);
      emit(state.copyWith(folders: filtered));
    } else if (tabIndex == 1) {
      // Files (server-side)
      _fetchFiles(query); // async, beklemeden çağırıyoruz
    } else if (tabIndex == 2) {
      // Images (server-side, paged reset)
      loadImagesInitial(); // async
    } else if (tabIndex == 3) {
      // ALL => üç listeyi birlikte güncelle
      final filtered = _filterFolders(state.allFolders, query);
      emit(state.copyWith(folders: filtered));
      _fetchFiles(query); // files
      loadImagesInitial(); // images
    }
  }

  void applyFilterForTab(int tabIndex) {
    if (tabIndex == 0) {
      final filtered = _filterFolders(state.allFolders, state.qsearch);
      emit(state.copyWith(folders: filtered));
    } else if (tabIndex == 1) {
      loadFiles();
    } else if (tabIndex == 2) {
      loadImagesInitial();
    } else if (tabIndex == 3) {
      // ALL: mevcut qsearch ile hepsini tazele
      final filtered = _filterFolders(state.allFolders, state.qsearch);
      emit(state.copyWith(folders: filtered));
      loadFiles();
      loadImagesInitial();
    }
  }

  setSelectedFolder(String v) => emit(state.copyWith(selectedFolder: v));

  void clearSearch(int tabIndex) => setSearchQueryForTab(tabIndex, '');

  Future<void> downloadFile(String fileLink) async {
    final Uri url = Uri.parse(fileLink);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Bu URL açılamıyor: $fileLink';
    }
  }

  Future<void> addFolder(String name) async {
    await InjectionContainerItems.contentRepository.createFolder(
      name,
      state.selectedFolder,
    );
    emit(state.copyWith(createStatus: CreateStatus.success));
    await loadFolders();
  }

  void resetStatus() =>
      emit(state.copyWith(createStatus: CreateStatus.failure));

  Future<void> renameFolder(String folderId, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;

    final newList = state.allFolders.map<FileFolderListModel>((e) {
      if (e.fldId == folderId) {
        return e.copyWith(name: newName);
      }
      return e;
    }).toList();

    emit(state.copyWith(allFolders: newList));

    /* final prevAll = state.allFolders;
    final patchedAll = [
      for (final f in prevAll)
        if (isIntFldId
            ? f.fldId ==
                  int.tryParse(folderId) // fldId int ise
            : f.fldId.toString() == folderId) // fldId string ise
          f.copyWith(name: trimmed)
        else
          f,
    ]; */
    final patchedFiltered = _filterFolders(newList, state.qsearch);

    await InjectionContainerItems.contentRepository.renameFolder(
      folderId,
      trimmed,
    );

    //await _reloadFoldersBust();
    emit(state.copyWith(allFolders: newList, folders: patchedFiltered));
  }

  Future<void> moveFileToFolders(String fileCode, int fileId) async {
    await InjectionContainerItems.contentRepository.moveFileToFolders(
      fileCode,
      fileId,
    );
    debugPrint('File moved successfully: $fileCode');
  }

  void searchBarOnChanged(BuildContext context, String v) {
    final uiIndex = DefaultTabController.of(context).index;
    final eff = uiToCubit(uiIndex); // All(0)->3, diğerleri -1
    context.read<HomeCubit>().setSearchQueryForTab(eff, v);
  }

  int uiToCubit(int ui) => ui == 0 ? 3 : ui - 1;

  void onTabChanged(int uiIndex) {
    final eff = uiToCubit(uiIndex);
    applyFilterForTab(eff);
  }
}
