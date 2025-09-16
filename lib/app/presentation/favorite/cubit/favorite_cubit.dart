import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState.initial()) {
    // Uygulama açılır açılmaz Hive'daki verileri state'e yaz
    emit(state.copyWith(favorites: box.values.toList()));
  }
  Box get box => Hive.box('favorite_box');

  void addFavoriteFolder(FileFolderListModel folder) {
    box.add({'id': folder.fldId, 'name': folder.name, 'type': 'folder'});
    emit(state.copyWith(favorites: box.values.toList()));
  }

  void addFavoriteFile(FileItem file) {
    final String fileKey = file.link; // ✅ benzersiz kabul ediyoruz
    box.add({'id': fileKey, 'name': file.name, 'type': 'file'});
    emit(state.copyWith(favorites: box.values.toList()));
  }

  void addFavoriteImages(FileItem image) {
    final String imageKey = image.link;
    box.add({'id': imageKey, 'name': image.name, 'type': 'image'});
    emit(state.copyWith(favorites: box.values.toList()));
  }

  void clearAllFavorites() {
    box.clear();
    emit(state.copyWith(favorites: []));
  }

  void removeFavoriteImage(String fileKey) {
    // (ismi de netleştirdim)
    final entries = box.toMap();
    for (var e in entries.entries) {
      final v = e.value;
      if (v is Map && v['id'] == fileKey && v['type'] == 'image') {
        box.delete(e.key);
        break;
      }
    }
    emit(state.copyWith(favorites: box.values.toList()));
  }

  void removeFavoriteFile(String fileKey) {
    final entries = box.toMap();
    for (var e in entries.entries) {
      final v = e.value;
      if (v is Map && v['link'] == fileKey && v['type'] == 'file') {
        box.delete(e.key);
        break;
      }
    }
    emit(state.copyWith(favorites: box.values.toList()));
  }

  bool isFavoriteFolder(String fldId) {
    return state.favoriteFolders.any(
      (fav) => fav['id'] == fldId && fav['type'] == 'folder',
    );
  }

  bool isFavoriteFile(String fileId) {
    return state.favoriteFolders.any(
      (fav) => fav['id'] == fileId && fav['type'] == 'file',
    );
  }

  void removeFavoriteFolder(String fldId) {
    final entries = box.toMap();
    for (var entry in entries.entries) {
      final value = entry.value;
      if (value is Map && value['id'] == fldId && value['type'] == 'folder') {
        box.delete(entry.key);
        break;
      }
    }
    emit(state.copyWith(favorites: box.values.toList()));
  }
}
