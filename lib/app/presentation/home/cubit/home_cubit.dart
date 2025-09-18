import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
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
            bustCache: true,

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
      debugPrint(result.toString());
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

  Future<void> downloadFile(String fileLink) async {
    try {
      await InjectionContainerItems.contentRepository.downloadFile(fileLink);
      // İndirme başarılı olduğunda kullanıcıya bildirim göster
      debugPrint('File downloaded successfully: $fileLink');
    } catch (e) {
      // Hata durumunda kullanıcıya hata mesajı göster
      debugPrint('Error downloading file: $e');
    }
  }

  Future<void> addFolder(String name) async {
    await InjectionContainerItems.contentRepository.createFolder(
      name,
      state.selectedFolder,
    );
    await loadFolders();
  }

  Future<void> renameFolder(String folderId, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;

    // 🟦 Tip uyumu: fldId tipin INT ise bu satırı kullan:
    final isIntFldId =
        state.allFolders.isNotEmpty && state.allFolders.first.fldId is int;

    // 1) Optimistic update: ekranda anında yeni isim
    final prevAll = state.allFolders;
    final patchedAll = [
      for (final f in prevAll)
        if (isIntFldId
            ? f.fldId ==
                  int.tryParse(folderId) // fldId int ise
            : f.fldId.toString() == folderId) // fldId string ise
          f.copyWith(name: trimmed)
        else
          f,
    ];
    final patchedFiltered = _filterFolders(patchedAll, state.qFolder);
    emit(state.copyWith(allFolders: patchedAll, folders: patchedFiltered));

    try {
      // 2) Sunucuya yaz
      await InjectionContainerItems.contentRepository.renameFolder(
        folderId,
        trimmed,
      );

      // 3) Kesin sonuç için cache-bust ile tekrar çek
      await _reloadFoldersBust();
    } catch (e) {
      // 4) Hata: optimistic update’ı geri al
      emit(
        state.copyWith(
          allFolders: prevAll,
          folders: _filterFolders(prevAll, state.qFolder),
        ),
      );
      rethrow;
    }
  }

  Future<void> _reloadFoldersBust() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await InjectionContainerItems.contentRepository
          .getFolderList(
            fldId: state.currentFldId,
            bustCache: true, // cache’i kır
          );
      final filtered = _filterFolders(result, state.qFolder);
      emit(
        state.copyWith(isLoading: false, allFolders: result, folders: filtered),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> moveSelectedFile() async {
    final code = state.fileCodeToMove;
    final target = state.selectedFolderForMove;

    if (code == null || target == null) {
      // kullanıcıya SnackBar/Toast gösterebilirsin
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      await InjectionContainerItems.contentRepository.moveFileToFolder(
        fileCode: code,
        targetFolderId: target,
      );

      // başarılı -> listeyi yenile, seçimleri sıfırla
      await loadFiles(); // veya loadContents()
      emit(
        state.copyWith(
          isLoading: false,
          fileCodeToMove: null,
          selectedFolder: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // hata göster
    }
  }

  void setFileCodeToMove(String? code) =>
      emit(state.copyWith(fileCodeToMove: code));
}
