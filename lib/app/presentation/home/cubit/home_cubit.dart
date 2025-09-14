import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    loadProfileData();
    // Demo: klasörleri doldur (sonra repository’den getirirsin)
    hydrateListsFromHive();
  }

  Future<void> loadContents() async {
    emit(state.copyWith(isLoading: true));
    try {
      await InjectionContainerItems.contentRepository.getContent();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadProfileData() async {
    emit(state.copyWith(isLoading: true));
    try {
      // Repo'nun AccountModel döndürdüğünü varsayıyoruz
      final account = await InjectionContainerItems.appAccountRepository
          .fetchAccountDetails();

      debugPrint("HomeCubit - Account Info: $account");

      emit(state.copyWith(isLoading: false, acountInfos: account));
    } catch (e) {
      // İstersen burada error alanı ekleyebilirsin (state’e error field eklemek gerekir)
      emit(state.copyWith(isLoading: false));
    }
  }

  void setGridView(bool value) {
    emit(state.copyWith(isGridView: value));
  }

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void handleRefresh() {
    loadProfileData();
    hydrateActiveList();
  }

  void setSearchQueryForTab(int tabIndex, String v) {
    switch (tabIndex) {
      case 0:
        emit(state.copyWith(qFolder: v));
        break;
      case 1:
        emit(state.copyWith(qFile: v));
        break;
      case 2:
        emit(state.copyWith(qImage: v));
        break;
    }
  }

  void setFolderQuery(String v) => emit(state.copyWith(qFolder: v));
  void setFileQuery(String v) => emit(state.copyWith(qFile: v));
  void setImageQuery(String v) => emit(state.copyWith(qImage: v));

  void clearSearch(int tabIndex) => setSearchQueryForTab(tabIndex, '');

  // Demo: klasör ekle
  void addFolder(String name) async {
    await InjectionContainerItems.contentRepository.createFolder(name);
    await hydrateActiveList();
  }

  Future<void> hydrateListsFromHive({String? parentId}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final folders = await InjectionContainerItems.contentRepository
          .getContentsByType('folder');
      final files = await InjectionContainerItems.contentRepository
          .getContentsByType('file');
      final images = await InjectionContainerItems.contentRepository
          .getContentsByType('image');

      emit(state.copyWith(isLoading: false, folderContent: folders));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Yalnızca aktif tab’ı yenile (performans için güzel)
  Future<void> hydrateActiveList({String? parentId}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final idx = state.selectedIndex; // 0: folder, 1: file, 2: image
      final type = idx == 0
          ? 'folder'
          : idx == 1
          ? 'file'
          : 'image';
      final list = await InjectionContainerItems.contentRepository
          .getContentsByType(type);

      switch (idx) {
        case 0:
          emit(
            state.copyWith(isLoading: false, folderContent: list),
          ); // ⬅️ değişti
          break;
        case 1:
          // ileride file tarafını da modele geçirince burada fileContent set et
          emit(
            state.copyWith(
              isLoading: false,
              fileNames: list.map((e) => e.name).toList(),
            ),
          );
          break;
        case 2:
          emit(
            state.copyWith(
              isLoading: false,
              imageNames: list.map((e) => e.name).toList(),
            ),
          );
          break;
      }
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
