import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState.initial());

  Box get box => Hive.box('favorite_box');

  void addFavoriteFolder(FileFolderListModel folder) {
    box.add({'id': folder.fldId, 'name': folder.name, 'type': 'folder'});
    emit(state.copyWith(favorites: box.values.toList()));
  }

  void isFavoriteControl() {
    final entries = box.toMap();
    bool isFav = false;
    for (var entry in entries.entries) {
      final value = entry.value;
      if (value is Map && value['id'] == state.favoriteFolders && value['type'] == 'folder') {
        isFav = true;
        break;
      }
    }
    emit(state.copyWith(favorites: box.values.toList()));

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
