import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/presentation/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._totalPages)
    : controller = PageController(initialPage: 0),
      super(SplashState(index: 0, totalPages: _totalPages));

  final int _totalPages;
  final PageController controller;

  void updatePage(int index) {
    if (index < 0) index = 0;
    if (index >= _totalPages) index = _totalPages - 1;
    if (index != state.index) {
      emit(state.copyWith(index: index));
      // debugPrint('onPageChanged -> $index');
    } else {
      emit(state.copyWith(index: index - 1));
    }
  }

  Future<void> nextPage() async {
    if (state.index < _totalPages - 1) {
      await controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
