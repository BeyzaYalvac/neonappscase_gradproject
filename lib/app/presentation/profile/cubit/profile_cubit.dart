// profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> loadProfieData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await InjectionContainerItems.appAccountRepository.fetchAccountDetails();
      emit(state.copyWith(isLoading: false, acountInfos: data));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
