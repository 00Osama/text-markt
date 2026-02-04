import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

enum LanguageState { english, arabic, french }

class LanguageCubit extends Cubit<LanguageState> {
  final SharedPreferences sharedPreferences;
  LanguageCubit({required this.sharedPreferences})
      : super(LanguageState.english);

  void setLanguage(LanguageState languageState) {
    emit(languageState);
    sharedPreferences.setString('language', languageState.toString());
  }

  void loadLanguagePreference() {
    final storedLanguage = sharedPreferences.getString('language');
    if (storedLanguage != null) {
      if (storedLanguage == 'LanguageState.arabic') {
        emit(LanguageState.arabic);
      } else if (storedLanguage == 'LanguageState.french') {
        emit(LanguageState.french);
      } else {
        emit(LanguageState.english);
      }
    } else {
      emit(LanguageState.english);
    }
  }

  Locale get locale {
    switch (state) {
      case LanguageState.arabic:
        return const Locale('ar');
      case LanguageState.french:
        return const Locale('fr');
      case LanguageState.english:
        return const Locale('en');
    }
  }
}
