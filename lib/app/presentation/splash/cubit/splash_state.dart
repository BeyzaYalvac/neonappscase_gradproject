import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final int index;
  final int totalPages;

  const SplashState({required this.index, required this.totalPages});

  SplashState copyWith({
    int? totalPages,
    required int? index,
    bool? readyToNavigate,
  }) {
    return SplashState(
      index: index ?? this.index,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  bool get isLast => index == totalPages - 1;

  @override
  List<Object?> get props => [index, totalPages];
}
