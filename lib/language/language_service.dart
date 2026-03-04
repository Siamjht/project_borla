
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageService {
  static const _langKey = 'lang';
  static const _countryKey = 'country';
  static String setLang = 'en';

  static Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final lang = prefs.getString(_langKey);
    final country = prefs.getString(_countryKey);
    setLang = lang ?? 'en';

    if (lang != null) {
      return Locale(lang, country);
    }
    return const Locale('en', 'US');
  }

  static Future<void> changeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_langKey, locale.languageCode);
    await prefs.setString(_countryKey, locale.countryCode ?? '');

    Get.updateLocale(locale);
  }
}
