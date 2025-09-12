import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/theme/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final Box _box;
  static const String _themeKey = 'theme_key';

  static ThemeState _initialFromBox(Box box) {
    final saved = box.get(_themeKey, defaultValue: 'light') as String;
    return ThemeState(themeMode: _stringToMode(saved));
  }

  ThemeCubit(this._box) : super(_initialFromBox(_box));

  static ThemeMode _stringToMode(String v) {
    switch (v) {
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  static String _modeToString(ThemeMode m) {
    switch (m) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      default:
        return 'light';
    }
  }

  //Doğrudan theme Set(?)
  void setTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    _box.put(_themeKey, _modeToString(mode));
  }

  //Buton döngüsüüü
  void toggle() {
    final next = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    setTheme(next);
    emit(state.copyWith(themeMode: next));
  }
}
