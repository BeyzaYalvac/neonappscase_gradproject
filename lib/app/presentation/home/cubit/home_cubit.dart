import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container_items.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    loadProfieData();
  }

  Future<void> loadContents() async {
    emit(state.copyWith(isLoading: true));
    try {
      await InjectionContainerItems.contentRepository.getContent();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadProfieData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await InjectionContainerItems.appAccountRepository
          .fetchAccountDetails();
      emit(state.copyWith(isLoading: false, acountInfos: data));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void setGridView(bool value) {
    emit(state.copyWith(isGridView: value));
  }

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void handleRefresh() {
    loadProfieData();
  }
}
