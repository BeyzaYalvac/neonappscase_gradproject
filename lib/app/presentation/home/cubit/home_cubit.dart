import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static const int _perPage = 5;

  HomeCubit() : super(HomeState.initial()) {
    loadProfileData();
    loadImagesInitial();
    loadFolders();
    //loadFiles();
    // İlk yüklemede klasör ve dosyaları çekmek istersen:
    // loadContents();
  }
  // Detay için: ilk frame'de loader ile başla, hiçbir auto-load yapma
  HomeCubit.forDetail() : super(HomeState.initial().copyWith(isLoading: true));

  Future<void> loadFolders() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await InjectionContainerItems.contentRepository
          .getFolderList(
            fldId: state.currentFldId,
            // Eğer API server-side isim filtresi destekliyorsa:
            // nameFilter: state.qFolder.isEmpty ? null : state.qFolder,
          );

      // Ham listeyi sakla ve aktif qFolder’a göre ekrana yansıt
      final filtered = _filterFolders(result, state.qFolder);
      emit(
        state.copyWith(isLoading: false, allFolders: result, folders: filtered),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getFoldersInFolder(int fldId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await InjectionContainerItems.contentRepository
          .getFolderList(fldId: fldId);
      emit(state.copyWith(isLoading: false, folders: result));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  List<FileFolderListModel> _filterFolders(
    List<FileFolderListModel> source,
    String query,
  ) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return List<FileFolderListModel>.from(source);
    return source.where((f) => (f.name).toLowerCase().contains(q)).toList();
  }

  Future<void> loadFiles() async {
    emit(state.copyWith(isLoading: true));
    try {
      final all = await InjectionContainerItems.contentRepository.getFileList(
        fldId: state.currentFldId,
        nameFilter: state.qFile.isEmpty ? null : state.qFile,
      );

      // .png / .jpg / .jpeg ile bitmeyenler
      final nonImages = all.where((f) {
        final name = f.name.trim().toLowerCase();
        return !(name.endsWith('.png') ||
            name.endsWith('.jpg') ||
            name.endsWith('.jpeg'));
      }).toList();

      emit(state.copyWith(isLoading: false, files: nonImages));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  // 2.1) İlk sayfa (listeyi sıfırla)
  Future<void> loadImagesInitial() async {
    emit(state.copyWith(isLoading: true, imagesPage: 1, imagesHasMore: true));
    try {
      final page = 1;
      final all = await InjectionContainerItems.contentRepository.getFileList(
        fldId: state.currentFldId,
        nameFilter: state.qFile.isEmpty ? null : state.qFile,
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
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  // 2.2) Devamını getir (append)
  Future<void> loadMoreImages() async {
    if (state.isLoadingMore || !state.imagesHasMore) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final nextPage = state.imagesPage + 1;

      final all = await InjectionContainerItems.contentRepository.getFileList(
        fldId: state.currentFldId,
        nameFilter: state.qFile.isEmpty ? null : state.qFile,
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
          // ⬇️ yine ham listeye göre
          imagesHasMore: all.length == _perPage,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> loadProfileData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final account = await InjectionContainerItems.appAccountRepository
          .fetchAccountDetails();
      emit(state.copyWith(isLoading: false, acountInfos: account));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<List<FileItem>?> getFilesInFolder(int fldId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await InjectionContainerItems.contentRepository
          .getFileList(fldId: fldId);
      emit(state.copyWith(isLoading: false, files: result));
      print(result);
      return result;
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
    return null;
  }

  void setGridView(bool value) => emit(state.copyWith(isGridView: value));
  void setSelectedIndex(int index) =>
      emit(state.copyWith(selectedIndex: index));
  void handleRefresh() => loadProfileData();

  // 🔵 ARAMA: Aktif taba göre ilgili query'yi güncelle ve gerekiyorsa server-side ara
  void setSearchQueryForTab(int tabIndex, String query) {
    if (tabIndex == 0) {
      // Folders tab → sadece client-side filtre uygula
      setFolderQuery(query);
    } else if (tabIndex == 1) {
      emit(state.copyWith(qFile: query));

      _fetchFiles(query); // server-side arama varsa burada
    } else {
      emit(state.copyWith(qFile: query));
      loadImagesInitial();

      _fetchFiles(query);
    }
  }

  void setFolderQuery(String v) {
    // allFolders -> ham liste; qFolder değişince client-side filtre uygula
    final filtered = _filterFolders(state.allFolders, v);
    emit(state.copyWith(qFolder: v, folders: filtered));
  }

  //folder create ederken selected folder seçmek
  setSelectedFolder(String v) => emit(state.copyWith(selectedFolder: v));

  void setFileQuery(String v) => emit(state.copyWith(qFile: v));

  void clearSearch(int tabIndex) => setSearchQueryForTab(tabIndex, '');

  // 🔵 Sunucu taraflı isim filtreli dosya çekme
  Future<void> _fetchFiles(String nameFilter) async {
    debugPrint('Files: ${state.files.length}');

    emit(state.copyWith(isLoading: true));
    try {
      final res = await InjectionContainerItems.contentRepository.getFileList(
        fldId: state.currentFldId,
        nameFilter: nameFilter.isEmpty
            ? null
            : state.qFile, // server-side filter
      );
      emit(state.copyWith(isLoading: false, files: res));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> addFolder(String name) async {
    await InjectionContainerItems.contentRepository.createFolder(
      name,
      state.selectedFolder,
    );
    await loadFolders();
  }
}
