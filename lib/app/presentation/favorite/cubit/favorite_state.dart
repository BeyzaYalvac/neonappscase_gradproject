import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final List favoriteFolders;
  final bool isFavorite;
  const FavoriteState(this.favoriteFolders, this.isFavorite);

  factory FavoriteState.initial() {
    return FavoriteState([], false);
  }

  FavoriteState copyWith({List? favorites}) {
    return FavoriteState(favorites ?? favoriteFolders, isFavorite);
  }

  @override
  List<Object?> get props => [favoriteFolders, isFavorite];
}
