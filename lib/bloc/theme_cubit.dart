import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeState { system, light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeCubit({required this.sharedPreferences}) : super(ThemeState.system);

  void setThemeMode(ThemeState themeState) {
    emit(themeState);
    sharedPreferences.setString('themeMode', themeState.toString());
  }

  void loadThemePreference() {
    String? storedTheme = sharedPreferences.getString('themeMode');
    if (storedTheme != null) {
      if (storedTheme == 'ThemeState.dark') {
        emit(ThemeState.dark);
      } else if (storedTheme == 'ThemeState.light') {
        emit(ThemeState.light);
      } else {
        emit(ThemeState.system);
      }
    } else {
      emit(ThemeState.system);
    }
  }

  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
        return ThemeMode.light;
      case ThemeState.dark:
        return ThemeMode.dark;
      case ThemeState.system:
        return ThemeMode.system;
    }
  }
}
