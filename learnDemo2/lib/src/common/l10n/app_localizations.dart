// 本地化代理类

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

// 生成的本地化代理和消息类将在此导入
// 注意：实际使用时，这些文件将由Flutter工具生成
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 由于我们没有实际生成这些文件，这里提供一个简单的实现
// 在实际项目中，您应该使用Flutter的国际化工具生成这些文件
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // 用于在Widget树中获取AppLocalizations实例
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // 定义支持的语言
  static const List<Locale> supportedLocales = [
    Locale('en'),     // 英语
    Locale('zh'),     // 简体中文
    Locale('zh', 'TW'), // 繁体中文
  ];

  // 本地化代理
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // 本地化字符串映射
  Map<String, String> _localizedStrings = {};

  // 加载本地化字符串
  Future<bool> load() async {
    // 在实际项目中，这里应该加载ARB文件或其他资源文件
    // 由于我们没有生成这些文件，这里使用硬编码的字符串
    if (locale.languageCode == 'zh') {
      // 区分简体中文和繁体中文
      if (locale.countryCode == 'TW') {
        // 繁体中文
        _localizedStrings = {
          'appName': 'Flutter MVVM + Repository 模式示例',
          'loadingText': '加載中...',
          'errorText': '加載失敗，請重試',
          'emptyText': '暫無數據',
          'pageTitleUserList': '用戶列表',
          'pageTitleUserDetail': '用戶詳情',
          'pageTitleAddUser': '添加用戶',
          'pageTitleEditUser': '編輯用戶',
          'pageTitleProfile': '個人資料',
          'pageTitleSettings': '設定',
          'pageTitleAbout': '關於我們',
          'buttonRefresh': '刷新',
          'buttonAdd': '添加',
          'buttonEdit': '編輯',
          'buttonDelete': '刪除',
          'buttonSave': '保存',
          'buttonCancel': '取消',
          'buttonRetry': '重試',
          'buttonConfirm': '確認',
          'buttonLogout': '退出登錄',
          'confirmDeleteTitle': '確認刪除',
          'confirmDeleteMessage': '確定要刪除這個用戶嗎？',
          'userName': '姓名',
          'userEmail': '郵箱',
          'userPhone': '電話（可選）',
          'validationNameRequired': '請輸入姓名',
          'validationEmailRequired': '請輸入郵箱',
          'validationEmailInvalid': '請輸入有效的郵箱地址',
          'successUserAdded': '用戶添加成功',
          'errorUserAddFailed': '添加用戶失敗',
        };
      } else {
        // 简体中文
        _localizedStrings = {
          'appName': 'Flutter MVVM + Repository 模式示例',
          'loadingText': '加载中...',
          'errorText': '加载失败，请重试',
          'emptyText': '暂无数据',
          'pageTitleUserList': '用户列表',
          'pageTitleUserDetail': '用户详情',
          'pageTitleAddUser': '添加用户',
          'pageTitleEditUser': '编辑用户',
          'pageTitleProfile': '个人资料',
          'pageTitleSettings': '设置',
          'pageTitleAbout': '关于我们',
          'buttonRefresh': '刷新',
          'buttonAdd': '添加',
          'buttonEdit': '编辑',
          'buttonDelete': '删除',
          'buttonSave': '保存',
          'buttonCancel': '取消',
          'buttonRetry': '重试',
          'buttonConfirm': '确认',
          'buttonLogout': '退出登录',
          'confirmDeleteTitle': '确认删除',
          'confirmDeleteMessage': '确定要删除这个用户吗？',
          'userName': '姓名',
          'userEmail': '邮箱',
          'userPhone': '电话（可选）',
          'validationNameRequired': '请输入姓名',
          'validationEmailRequired': '请输入邮箱',
          'validationEmailInvalid': '请输入有效的邮箱地址',
          'successUserAdded': '用户添加成功',
          'errorUserAddFailed': '添加用户失败',
        };
      }
    } else {
      // 默认使用英语
      _localizedStrings = {
        'appName': 'Flutter MVVM + Repository Demo',
        'loadingText': 'Loading...',
        'errorText': 'Loading failed, please try again',
        'emptyText': 'No data available',
        'pageTitleUserList': 'User List',
        'pageTitleUserDetail': 'User Detail',
        'pageTitleAddUser': 'Add User',
        'pageTitleEditUser': 'Edit User',
        'pageTitleProfile': 'Profile',
        'pageTitleSettings': 'Settings',
        'pageTitleAbout': 'About Us',
        'buttonRefresh': 'Refresh',
        'buttonAdd': 'Add',
        'buttonEdit': 'Edit',
        'buttonDelete': 'Delete',
        'buttonSave': 'Save',
        'buttonCancel': 'Cancel',
        'buttonRetry': 'Retry',
        'buttonConfirm': 'Confirm',
        'buttonLogout': 'Logout',
        'confirmDeleteTitle': 'Confirm Delete',
        'confirmDeleteMessage': 'Are you sure you want to delete this user?',
        'userName': 'Name',
        'userEmail': 'Email',
        'userPhone': 'Phone (optional)',
        'validationNameRequired': 'Please enter name',
        'validationEmailRequired': 'Please enter email',
        'validationEmailInvalid': 'Please enter a valid email address',
        'successUserAdded': 'User added successfully',
        'errorUserAddFailed': 'Failed to add user',
      };
    }
    return true;
  }

  // 获取本地化字符串的方法
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // 以下是一些常用的本地化字符串的快捷访问方法
  String get appName => translate('appName');
  String get loadingText => translate('loadingText');
  String get errorText => translate('errorText');
  String get emptyText => translate('emptyText');
  String get pageTitleUserList => translate('pageTitleUserList');
  String get pageTitleAddUser => translate('pageTitleAddUser');
  String get pageTitleEditUser => translate('pageTitleEditUser');
  String get buttonAdd => translate('buttonAdd');
  String get buttonSave => translate('buttonSave');
  String get buttonCancel => translate('buttonCancel');
  String get buttonConfirm => translate('buttonConfirm');
  String get userName => translate('userName');
  String get userEmail => translate('userEmail');
  String get userPhone => translate('userPhone');
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
    // 加载本地化资源
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// 提供所有需要的本地化代理
class AppLocalizationsDelegates {
  static const List<LocalizationsDelegate<dynamic>> delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}