// 语言提供者类

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/l10n/app_localizations.dart';

class LanguageProvider extends ChangeNotifier {
  // 语言偏好设置的键
  static const String _languagePreferenceKey = 'selected_language';

  // 当前语言
  Locale _currentLocale = const Locale('en');

  // 支持的语言列表
  final List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  LanguageProvider() {
    // 初始化时加载保存的语言偏好
    _loadSavedLanguage();
  }

  // 获取当前语言
  Locale get currentLocale => _currentLocale;

  // 设置语言
  Future<void> setLanguage(Locale locale) async {
    if (supportedLocales.contains(locale)) {
      _currentLocale = locale;
      // 保存语言偏好
      await _saveLanguagePreference(locale.languageCode);
      // 通知监听器
      notifyListeners();
    }
  }

  // 加载保存的语言偏好
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languagePreferenceKey);
      
      if (languageCode != null && languageCode.isNotEmpty) {
        final locale = Locale(languageCode);
        if (supportedLocales.contains(locale)) {
          _currentLocale = locale;
        }
      } else {
        // 如果没有保存的偏好，使用系统语言
        _currentLocale = await _getSystemLocale();
      }
    } catch (e) {
      print('Failed to load language preference: $e');
      // 加载失败时使用默认语言
      _currentLocale = const Locale('en');
    }
  }

  // 获取系统语言
  Future<Locale> _getSystemLocale() async {
    try {
      // 获取设备首选语言
      final systemLocales = WidgetsBinding.instance.window.locales;
      if (systemLocales.isNotEmpty) {
        // 检查系统语言是否在我们支持的语言列表中
        for (final locale in systemLocales) {
          // 先检查完整的语言代码（语言+地区）
          if (supportedLocales.contains(locale)) {
            return locale;
          }
          // 再检查仅语言代码
          final languageOnlyLocale = Locale(locale.languageCode);
          if (supportedLocales.contains(languageOnlyLocale)) {
            return languageOnlyLocale;
          }
        }
      }
    } catch (e) {
      print('Failed to get system locale: $e');
    }
    // 如果无法获取系统语言或系统语言不受支持，返回默认语言
    return const Locale('en');
  }

  // 保存语言偏好
  Future<void> _saveLanguagePreference(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languagePreferenceKey, languageCode);
    } catch (e) {
      print('Failed to save language preference: $e');
    }
  }

  // 获取语言显示名称
  String getLanguageDisplayName(Locale locale) {
    if (locale.languageCode == 'zh') {
      if (locale.countryCode == 'TW') {
        return '繁體中文';
      } else {
        return '简体中文';
      }
    } else if (locale.languageCode == 'en') {
      return 'English';
    } else {
      return locale.languageCode;
    }
  }

  // 获取当前语言的显示名称
  String get currentLanguageDisplayName {
    return getLanguageDisplayName(_currentLocale);
  }
}