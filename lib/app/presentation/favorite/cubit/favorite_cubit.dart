import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  FavoriteCubit() : super(FavoriteState.initial());
  
  void addFavoriteFile(String filePath) {
    //TODO: implement add favorite file
  }

  void removeFavoriteFile(String filePath) {
    //TODO: implement remove favorite file
  }
}