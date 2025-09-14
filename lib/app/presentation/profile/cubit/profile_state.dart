// profile_state.dart
import 'package:equatable/equatable.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final AccountModel? acountInfos;

  const ProfileState({this.isLoading = false, this.acountInfos});

  factory ProfileState.initial() => const ProfileState(acountInfos: null);

  ProfileState copyWith({bool? isLoading, AccountModel? acountInfos}) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      acountInfos: acountInfos ?? this.acountInfos,
    );
  }

  @override
  List<Object?> get props => [isLoading, acountInfos];
}
