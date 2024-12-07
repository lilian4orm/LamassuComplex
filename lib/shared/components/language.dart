import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  SharedPreferences? _prefs;

  LanguageCubit() : super(const Locale("ar")) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    _prefs = await SharedPreferences.getInstance();
    String? languageCode = _prefs!.getString('languageCode');
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    if (_prefs == null) {
      await _loadLocale();
    }
    _prefs!.setString('languageCode', locale.languageCode);
    emit(locale);
  }
}
