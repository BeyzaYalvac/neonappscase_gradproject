import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial()) {
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    emit(state.copyWith(isLoading: true));
  
      // Repo'nun AccountModel döndürdüğünü varsayıyoruz
      final account = await InjectionContainerItems.appAccountRepository
          .fetchAccountDetails();

      debugPrint("ProfileCubit - Account Info: $account");

      emit(state.copyWith(isLoading: false, acountInfos: account));
    
  }

  Future<void> refresh() => loadProfileData();
}
