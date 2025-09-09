import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  factory ThemeState.initial() {
    return const ThemeState(themeMode: ThemeMode.light);
  }

  @override
  List<Object?> get props => [themeMode];
}
