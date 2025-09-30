import 'package:equatable/equatable.dart';

enum FavoriteStatus { none, deleted }

class FavoriteState extends Equatable {
  final List favoriteFolders;
  final bool isFavorite;
  final FavoriteStatus favoriteStatus;
  const FavoriteState(
    this.favoriteFolders,
    this.isFavorite,
    this.favoriteStatus,
  );

  factory FavoriteState.initial() {
    return FavoriteState([], false, FavoriteStatus.none);
  }

  FavoriteState copyWith({List? favorites, FavoriteStatus? favoriteStatus}) {
    return FavoriteState(
      favorites ?? favoriteFolders,
      isFavorite,
      favoriteStatus ?? this.favoriteStatus,
    );
  }

  @override
  List<Object?> get props => [favoriteFolders, isFavorite, favoriteStatus];
}
