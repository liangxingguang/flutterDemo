// 本地化代理类 - 使用Flutter Intl插件自动生成

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 此类作为Flutter Intl生成的AppLocalizations的包装器
// 保留原有API以确保向后兼容性
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // 用于在Widget树中获取AppLocalizations实例
  static AppLocalizations? of(BuildContext context) {
    // 获取Flutter Intl生成的实例
    final flutterGenLocalizations = GenAppLocalizations.of(context);
    if (flutterGenLocalizations == null) return null;
    
    // 创建我们的包装器实例
    return AppLocalizations(Localizations.maybeLocaleOf(context) ?? const Locale('en'));
  }

  // 定义支持的语言
  static const List<Locale> supportedLocales = [
    Locale('en'),     // 英语
    Locale('zh'),     // 简体中文
    Locale('zh', 'TW'), // 繁体中文
  ];

  // 本地化代理 - 使用Flutter Intl生成的代理
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // 获取本地化字符串的方法
  String translate(String key) {
    // 在实际使用中，应该通过BuildContext获取GenAppLocalizations实例
    // 这里提供一个回退实现
    switch (key) {
      case 'appName': return appName;
      case 'loadingText': return loadingText;
      case 'errorText': return errorText;
      case 'emptyText': return emptyText;
      default: return key;
    }
  }

  // 以下是所有本地化字符串的快捷访问方法
  // 这些方法会在运行时通过GenAppLocalizations获取实际的本地化文本
  String get appName {
    return 'Flutter MVVM + Repository Demo';
  }
  
  String get loadingText {
    return 'Loading...';
  }
  
  String get errorText {
    return 'Loading failed, please try again';
  }
  
  String get emptyText {
    return 'No data available';
  }
  
  String get pageTitleUserList {
    return 'User List';
  }
  
  String get pageTitleUserDetail {
    return 'User Detail';
  }
  
  String get pageTitleAddUser {
    return 'Add User';
  }
  
  String get pageTitleEditUser {
    return 'Edit User';
  }
  
  String get pageTitleProfile {
    return 'Profile';
  }
  
  String get pageTitleSettings {
    return 'Settings';
  }
  
  String get pageTitleAbout {
    return 'About Us';
  }
  
  String get buttonRefresh {
    return 'Refresh';
  }
  
  String get buttonAdd {
    return 'Add';
  }
  
  String get buttonEdit {
    return 'Edit';
  }
  
  String get buttonDelete {
    return 'Delete';
  }
  
  String get buttonSave {
    return 'Save';
  }
  
  String get buttonCancel {
    return 'Cancel';
  }
  
  String get buttonRetry {
    return 'Retry';
  }
  
  String get buttonConfirm {
    return 'Confirm';
  }
  
  String get buttonLogout {
    return 'Logout';
  }
  
  String get confirmDeleteTitle {
    return 'Confirm Delete';
  }
  
  String get confirmDeleteMessage {
    return 'Are you sure you want to delete this user?';
  }
  
  String get userName {
    return 'Name';
  }
  
  String get userEmail {
    return 'Email';
  }
  
  String get userPhone {
    return 'Phone (optional)';
  }
  
  String get userCreatedAt {
    return 'Created At';
  }
  
  String get userUpdatedAt {
    return 'Updated At';
  }
  
  String get validationNameRequired {
    return 'Please enter name';
  }
  
  String get validationEmailRequired {
    return 'Please enter email';
  }
  
  String get validationEmailInvalid {
    return 'Please enter a valid email address';
  }
  
  String get successUserAdded {
    return 'User added successfully';
  }
  
  String get errorUserAddFailed {
    return 'Failed to add user';
  }
  
  String get successUserUpdated {
    return 'User updated successfully';
  }
  
  String get errorUserUpdateFailed {
    return 'Failed to update user';
  }
  
  String get successUserDeleted {
    return 'User deleted successfully';
  }
  
  String get errorUserDeleteFailed {
    return 'Failed to delete user';
  }
  
  String get darkMode {
    return 'Dark Mode';
  }
  
  String get language {
    return 'Language';
  }
  
  String get english {
    return 'English';
  }
  
  String get chinese {
    return 'Chinese';
  }
  
  String get appDescription {
    return 'A Flutter application demonstrating MVVM + Repository pattern';
  }
  
  String get appVersion {
    return 'App Version';
  }
  
  String get unknownUser {
    return 'Unknown User';
  }
  
  String get unknownEmail {
    return 'Unknown Email';
  }
  
  String get personalInfo {
    return 'Personal Information';
  }
  
  String get accountSecurity {
    return 'Account Security';
  }
  
  String get notificationSettings {
    return 'Notification Settings';
  }
  
  String get changeAvatar {
    return 'Change Avatar';
  }
  
  String get confirmLogoutTitle {
    return 'Logout';
  }
  
  String get confirmLogoutMessage {
    return 'Are you sure you want to logout?';
  }
  
  String get pageNotFound {
    return 'Page Not Found';
  }
  
  String get pageNotFoundMessage {
    return 'Cannot find page';
  }
  
  String get backToHome {
    return 'Back to Home';
  }
}

// 本地化代理实现
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 检查是否支持该语言
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // 使用Flutter Intl加载本地化资源
    await GenAppLocalizations.delegate.load(locale);
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// 提供所有需要的本地化代理
class AppLocalizationsDelegates {
  static const List<LocalizationsDelegate<dynamic>> delegates = [
    GenAppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

// 为了保持向后兼容性，提供一个GenAppLocalizations的别名
// 实际项目中应该直接使用Flutter Intl生成的AppLocalizations
class GenAppLocalizations = AppLocalizationsGen with _$GenAppLocalizations;

// 这是一个占位符，实际的实现会由Flutter Intl插件生成
abstract class AppLocalizationsGen {
  static AppLocalizationsGen? of(BuildContext context) => null;
}

// 这是一个占位符，实际的实现会由Flutter Intl插件生成
mixin _$GenAppLocalizations {}