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
    _saveLanguagePreference(languageState);
  }

  void _saveLanguagePreference(LanguageState languageState) {
    sharedPreferences.setString('language', languageState.toString());
  }

  void loadLanguagePreference() {
    String? storedLanguage = sharedPreferences.getString('language');
    if (storedLanguage != null) {
      switch (storedLanguage) {
        case 'LanguageState.arabic':
          emit(LanguageState.arabic);
          break;
        case 'LanguageState.french':
          emit(LanguageState.french);
          break;
        default:
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
