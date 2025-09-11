// 默认本地化字符串类
// 用于在无法获取AppLocalizations实例时提供默认的本地化文本

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 默认本地化字符串单例类
class DefaultLocalizations {
  // 私有构造函数
  DefaultLocalizations._();

  // 单例实例
  static final DefaultLocalizations instance = DefaultLocalizations._();

  // 默认的AppLocalizations实例
  late AppLocalizations _defaultLocalizations;

  // 初始化方法，需要在应用启动时调用
  void initialize() {
    // 创建一个默认的Locale
    const defaultLocale = Locale('en');
    
    // 创建一个默认的AppLocalizations实例
    // 注意：这只是一个模拟实例，实际应用中需要根据实际情况创建
    _defaultLocalizations = _MockAppLocalizations(defaultLocale);
  }

  // 获取本地化实例，优先返回传入的实例，否则返回默认实例
  AppLocalizations orDefault(AppLocalizations? localizations) {
    return localizations ?? _defaultLocalizations;
  }
}

// 模拟AppLocalizations类，用于提供默认的本地化文本
class _MockAppLocalizations implements AppLocalizations {
  final Locale _locale;

  _MockAppLocalizations(this._locale);

  @override
  String get appName => 'Flutter MVVM + Repository Demo';

  @override
  String get loadingText => 'Loading...';

  @override
  String get errorText => 'Loading failed, please try again';

  @override
  String get emptyText => 'No data available';

  @override
  String get pageTitleUserList => 'User List';

  @override
  String get pageTitleUserDetail => 'User Detail';

  @override
  String get pageTitleAddUser => 'Add User';

  @override
  String get pageTitleEditUser => 'Edit User';

  @override
  String get pageTitleProfile => 'Profile';

  @override
  String get pageTitleSettings => 'Settings';

  @override
  String get pageTitleAbout => 'About Us';

  @override
  String get buttonRefresh => 'Refresh';

  @override
  String get buttonAdd => 'Add';

  @override
  String get buttonEdit => 'Edit';

  @override
  String get buttonDelete => 'Delete';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonRetry => 'Retry';

  @override
  String get buttonConfirm => 'Confirm';

  @override
  String get buttonLogout => 'Logout';

  @override
  String get confirmDeleteTitle => 'Confirm Delete';

  @override
  String get confirmDeleteMessage => 'Are you sure you want to delete this user?';

  @override
  String get userName => 'Name';

  @override
  String get userEmail => 'Email';

  @override
  String get userPhone => 'Phone (optional)';

  @override
  String get userCreatedAt => 'Created At';

  @override
  String get userUpdatedAt => 'Updated At';

  @override
  String get validationNameRequired => 'Please enter name';

  @override
  String get validationEmailRequired => 'Please enter email';

  @override
  String get validationEmailInvalid => 'Please enter a valid email address';

  @override
  String get successUserAdded => 'User added successfully';

  @override
  String get errorUserAddFailed => 'Failed to add user';

  @override
  String get successUserUpdated => 'User updated successfully';

  @override
  String get errorUserUpdateFailed => 'Failed to update user';

  @override
  String get successUserDeleted => 'User deleted successfully';

  @override
  String get errorUserDeleteFailed => 'Failed to delete user';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get appDescription => 'A Flutter application demonstrating MVVM + Repository pattern';

  @override
  String get appVersion => 'App Version';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get unknownEmail => 'Unknown Email';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get accountSecurity => 'Account Security';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get changeAvatar => 'Change Avatar';

  @override
  String get confirmLogoutTitle => 'Logout';

  @override
  String get confirmLogoutMessage => 'Are you sure you want to logout?';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String get pageNotFoundMessage => 'Cannot find page';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get justNow => 'just now';

  @override
  String get oneMinuteAgo => '1 minute ago';

  @override
  String get minutesAgo => 'minutes ago';

  @override
  String get oneHourAgo => '1 hour ago';

  @override
  String get hoursAgo => 'hours ago';

  @override
  String get oneDayAgo => '1 day ago';

  @override
  String get daysAgo => 'days ago';

  @override
  String get oneMonthAgo => '1 month ago';

  @override
  String get monthsAgo => 'months ago';

  @override
  String get oneYearAgo => '1 year ago';

  @override
  String get yearsAgo => 'years ago';

  @override
  String get editUserFunctionNotImplemented => 'Edit user function not implemented';

  @override
  String get themeSwitchFunctionNotImplemented => 'Theme switch function not implemented';

  @override
  String get settingsFunctionNotImplemented => 'Settings function not implemented';

  @override
  String get changeAvatarFunctionNotImplemented => 'Change avatar function not implemented';

  @override
  String get editProfileFunctionNotImplemented => 'Edit profile function not implemented';

  @override
  String get accountSecurityFunctionNotImplemented => 'Account security function not implemented';

  @override
  String get notificationSettingsFunctionNotImplemented => 'Notification settings function not implemented';

  @override
  String get logoutFunctionNotImplemented => 'Logout function not implemented';

  @override
  // TODO: 实现其他AppLocalizations接口方法
  dynamic noSuchMethod(Invocation invocation) => '';

  @override
  Locale get locale => _locale;

  // 静态方法，用于获取实例
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // 静态属性，用于获取本地化代理
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    // 这里应该包含实际的本地化代理
  ];

  // 静态属性，用于获取支持的语言列表
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];
}