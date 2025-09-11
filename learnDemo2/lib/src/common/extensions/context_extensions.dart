// 针对BuildContext的扩展方法

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../l10n/default_localizations.dart';
import '../constants/localized_constants.dart';

// 对BuildContext的扩展，提供便捷的方法获取本地化实例
extension ContextLocalizations on BuildContext {
  // 获取本地化实例，如果为空则返回默认实例
  AppLocalizations get localizations {
    final defaultLocales = DefaultLocalizations.instance;
    final currentLocales = AppLocalizations.of(this);
    return defaultLocales.orDefault(currentLocales);
  }

  // 获取字符串资源的快捷方法
  String t(String Function(AppLocalizations) getter) {
    return getter(localizations);
  }

  // 获取本地化常量的快捷访问
  LocalizedConstantsHelper get consts {
    return LocalizedConstantsHelper(this);
  }
}

// 本地化常量助手类，提供对LocalizedConstants的便捷访问
class LocalizedConstantsHelper {
  final BuildContext _context;

  const LocalizedConstantsHelper(this._context);

  // 加载状态文本
  String get loadingText => LocalizedConstants.loadingText(_context);
  String get errorText => LocalizedConstants.errorText(_context);
  String get emptyText => LocalizedConstants.emptyText(_context);

  // 页面标题
  String get pageTitleUserList => LocalizedConstants.pageTitleUserList(_context);
  String get pageTitleUserDetail => LocalizedConstants.pageTitleUserDetail(_context);
  String get pageTitleAddUser => LocalizedConstants.pageTitleAddUser(_context);
  String get pageTitleEditUser => LocalizedConstants.pageTitleEditUser(_context);
  String get pageTitleProfile => LocalizedConstants.pageTitleProfile(_context);
  String get pageTitleSettings => LocalizedConstants.pageTitleSettings(_context);
  String get pageTitleAbout => LocalizedConstants.pageTitleAbout(_context);

  // 按钮文本
  String get buttonRefresh => LocalizedConstants.buttonRefresh(_context);
  String get buttonAdd => LocalizedConstants.buttonAdd(_context);
  String get buttonEdit => LocalizedConstants.buttonEdit(_context);
  String get buttonDelete => LocalizedConstants.buttonDelete(_context);
  String get buttonSave => LocalizedConstants.buttonSave(_context);
  String get buttonCancel => LocalizedConstants.buttonCancel(_context);
  String get buttonRetry => LocalizedConstants.buttonRetry(_context);
  String get buttonConfirm => LocalizedConstants.buttonConfirm(_context);
  String get buttonLogout => LocalizedConstants.buttonLogout(_context);

  // 确认对话框文本
  String get confirmDeleteTitle => LocalizedConstants.confirmDeleteTitle(_context);
  String get confirmDeleteMessage => LocalizedConstants.confirmDeleteMessage(_context);
  String get confirmLogoutTitle => LocalizedConstants.confirmLogoutTitle(_context);
  String get confirmLogoutMessage => LocalizedConstants.confirmLogoutMessage(_context);

  // 用户相关文本
  String get userName => LocalizedConstants.userName(_context);
  String get userEmail => LocalizedConstants.userEmail(_context);
  String get userPhone => LocalizedConstants.userPhone(_context);
  String get userCreatedAt => LocalizedConstants.userCreatedAt(_context);
  String get userUpdatedAt => LocalizedConstants.userUpdatedAt(_context);

  // 验证文本
  String get validationNameRequired => LocalizedConstants.validationNameRequired(_context);
  String get validationEmailRequired => LocalizedConstants.validationEmailRequired(_context);
  String get validationEmailInvalid => LocalizedConstants.validationEmailInvalid(_context);

  // 操作结果文本
  String get successUserAdded => LocalizedConstants.successUserAdded(_context);
  String get errorUserAddFailed => LocalizedConstants.errorUserAddFailed(_context);
  String get successUserUpdated => LocalizedConstants.successUserUpdated(_context);
  String get errorUserUpdateFailed => LocalizedConstants.errorUserUpdateFailed(_context);
  String get successUserDeleted => LocalizedConstants.successUserDeleted(_context);
  String get errorUserDeleteFailed => LocalizedConstants.errorUserDeleteFailed(_context);

  // 设置相关文本
  String get darkMode => LocalizedConstants.darkMode(_context);
  String get language => LocalizedConstants.language(_context);

  // 功能未实现文本
  String get editUserFunctionNotImplemented => LocalizedConstants.editUserFunctionNotImplemented(_context);
  String get themeSwitchFunctionNotImplemented => LocalizedConstants.themeSwitchFunctionNotImplemented(_context);
  String get settingsFunctionNotImplemented => LocalizedConstants.settingsFunctionNotImplemented(_context);
  String get changeAvatarFunctionNotImplemented => LocalizedConstants.changeAvatarFunctionNotImplemented(_context);
  String get editProfileFunctionNotImplemented => LocalizedConstants.editProfileFunctionNotImplemented(_context);
  String get accountSecurityFunctionNotImplemented => LocalizedConstants.accountSecurityFunctionNotImplemented(_context);
  String get notificationSettingsFunctionNotImplemented => LocalizedConstants.notificationSettingsFunctionNotImplemented(_context);
  String get logoutFunctionNotImplemented => LocalizedConstants.logoutFunctionNotImplemented(_context);
}

// 对AppLocalizations?的扩展，提供安全的访问方法
extension AppLocalizationsNullable on AppLocalizations? {
  // 获取安全的本地化实例，如果为空则返回默认实例
  AppLocalizations get safe {
    return DefaultLocalizations.instance.orDefault(this);
  }
}