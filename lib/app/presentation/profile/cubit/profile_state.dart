// profile_state.dart
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final Map<String, dynamic>? acountInfos;

  const ProfileState({this.isLoading = false, this.acountInfos});

  factory ProfileState.initial() => const ProfileState(acountInfos: {});

  ProfileState copyWith({bool? isLoading, Map<String, dynamic>? acountInfos}) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      acountInfos: acountInfos ?? this.acountInfos,
    );
  }

  @override
  List<Object?> get props => [isLoading, acountInfos];
}
