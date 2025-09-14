import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable{
  final List favoriteFiles;
  FavoriteState(this.favoriteFiles);

  factory FavoriteState.initial() {
    return FavoriteState([]);
  }

  FavoriteState copyWith({
    List? favoriteFiles,
  }) {
    return FavoriteState(
      favoriteFiles ?? this.favoriteFiles,
    );
  }

  @override
  List<Object?> get props => [favoriteFiles];
}