// 本地化常量工具类
// 提供访问本地化文本常量的方法

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 本地化常量工具类
class LocalizedConstants {
  // 私有构造函数，防止实例化
  LocalizedConstants._();

  // 获取加载状态文本
  static String loadingText(BuildContext context) {
    return context.localizations.loadingText;
  }

  // 获取错误状态文本
  static String errorText(BuildContext context) {
    return context.localizations.errorText;
  }

  // 获取空状态文本
  static String emptyText(BuildContext context) {
    return context.localizations.emptyText;
  }

  // 获取页面标题
  static String pageTitleUserList(BuildContext context) {
    return context.localizations.pageTitleUserList;
  }

  static String pageTitleUserDetail(BuildContext context) {
    return context.localizations.pageTitleUserDetail;
  }

  static String pageTitleAddUser(BuildContext context) {
    return context.localizations.pageTitleAddUser;
  }

  static String pageTitleEditUser(BuildContext context) {
    return context.localizations.pageTitleEditUser;
  }

  static String pageTitleProfile(BuildContext context) {
    return context.localizations.pageTitleProfile;
  }

  static String pageTitleSettings(BuildContext context) {
    return context.localizations.pageTitleSettings;
  }

  static String pageTitleAbout(BuildContext context) {
    return context.localizations.pageTitleAbout;
  }

  // 获取按钮文本
  static String buttonRefresh(BuildContext context) {
    return context.localizations.buttonRefresh;
  }

  static String buttonAdd(BuildContext context) {
    return context.localizations.buttonAdd;
  }

  static String buttonEdit(BuildContext context) {
    return context.localizations.buttonEdit;
  }

  static String buttonDelete(BuildContext context) {
    return context.localizations.buttonDelete;
  }

  static String buttonSave(BuildContext context) {
    return context.localizations.buttonSave;
  }

  static String buttonCancel(BuildContext context) {
    return context.localizations.buttonCancel;
  }

  static String buttonRetry(BuildContext context) {
    return context.localizations.buttonRetry;
  }

  static String buttonConfirm(BuildContext context) {
    return context.localizations.buttonConfirm;
  }

  static String buttonLogout(BuildContext context) {
    return context.localizations.buttonLogout;
  }

  // 获取确认对话框文本
  static String confirmDeleteTitle(BuildContext context) {
    return context.localizations.confirmDeleteTitle;
  }

  static String confirmDeleteMessage(BuildContext context) {
    return context.localizations.confirmDeleteMessage;
  }

  static String confirmLogoutTitle(BuildContext context) {
    return context.localizations.confirmLogoutTitle;
  }

  static String confirmLogoutMessage(BuildContext context) {
    return context.localizations.confirmLogoutMessage;
  }

  // 获取用户相关文本
  static String userName(BuildContext context) {
    return context.localizations.userName;
  }

  static String userEmail(BuildContext context) {
    return context.localizations.userEmail;
  }

  static String userPhone(BuildContext context) {
    return context.localizations.userPhone;
  }

  static String userCreatedAt(BuildContext context) {
    return context.localizations.userCreatedAt;
  }

  static String userUpdatedAt(BuildContext context) {
    return context.localizations.userUpdatedAt;
  }

  // 获取验证文本
  static String validationNameRequired(BuildContext context) {
    return context.localizations.validationNameRequired;
  }

  static String validationEmailRequired(BuildContext context) {
    return context.localizations.validationEmailRequired;
  }

  static String validationEmailInvalid(BuildContext context) {
    return context.localizations.validationEmailInvalid;
  }

  // 获取操作结果文本
  static String successUserAdded(BuildContext context) {
    return context.localizations.successUserAdded;
  }

  static String errorUserAddFailed(BuildContext context) {
    return context.localizations.errorUserAddFailed;
  }

  static String successUserUpdated(BuildContext context) {
    return context.localizations.successUserUpdated;
  }

  static String errorUserUpdateFailed(BuildContext context) {
    return context.localizations.errorUserUpdateFailed;
  }

  static String successUserDeleted(BuildContext context) {
    return context.localizations.successUserDeleted;
  }

  static String errorUserDeleteFailed(BuildContext context) {
    return context.localizations.errorUserDeleteFailed;
  }

  // 获取设置相关文本
  static String darkMode(BuildContext context) {
    return context.localizations.darkMode;
  }

  static String language(BuildContext context) {
    return context.localizations.language;
  }

  // 获取功能未实现文本
  static String editUserFunctionNotImplemented(BuildContext context) {
    return context.localizations.editUserFunctionNotImplemented;
  }

  static String themeSwitchFunctionNotImplemented(BuildContext context) {
    return context.localizations.themeSwitchFunctionNotImplemented;
  }

  static String settingsFunctionNotImplemented(BuildContext context) {
    return context.localizations.settingsFunctionNotImplemented;
  }

  static String changeAvatarFunctionNotImplemented(BuildContext context) {
    return context.localizations.changeAvatarFunctionNotImplemented;
  }

  static String editProfileFunctionNotImplemented(BuildContext context) {
    return context.localizations.editProfileFunctionNotImplemented;
  }

  static String accountSecurityFunctionNotImplemented(BuildContext context) {
    return context.localizations.accountSecurityFunctionNotImplemented;
  }

  static String notificationSettingsFunctionNotImplemented(BuildContext context) {
    return context.localizations.notificationSettingsFunctionNotImplemented;
  }

  static String logoutFunctionNotImplemented(BuildContext context) {
    return context.localizations.logoutFunctionNotImplemented;
  }
}