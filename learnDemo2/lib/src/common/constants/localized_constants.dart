// 本地化常量工具类
// 提供访问本地化文本常量的方法

import 'package:flutter/material.dart';
import '../l10n/generated/l10n.dart';

// 本地化常量工具类
class LocalizedConstants {
  // 私有构造函数，防止实例化
  LocalizedConstants._();

  // 获取加载状态文本
  static String loadingText(BuildContext context) {
    return S.of(context).loadingText;
  }

  // 获取错误状态文本
  static String errorText(BuildContext context) {
    return S.of(context).errorText;
  }

  // 获取空状态文本
  static String emptyText(BuildContext context) {
    return S.of(context).emptyText;
  }

  // 获取页面标题
  static String pageTitleUserList(BuildContext context) {
    return S.of(context).pageTitleUserList;
  }

  static String pageTitleUserDetail(BuildContext context) {
    return S.of(context).pageTitleUserDetail;
  }

  static String pageTitleAddUser(BuildContext context) {
    return S.of(context).pageTitleAddUser;
  }

  static String pageTitleEditUser(BuildContext context) {
    return S.of(context).pageTitleEditUser;
  }

  static String pageTitleProfile(BuildContext context) {
    return S.of(context).pageTitleProfile;
  }

  static String pageTitleSettings(BuildContext context) {
    return S.of(context).pageTitleSettings;
  }

  static String pageTitleAbout(BuildContext context) {
    return S.of(context).pageTitleAbout;
  }

  // 获取按钮文本
  static String buttonRefresh(BuildContext context) {
    return S.of(context).buttonRefresh;
  }

  static String buttonAdd(BuildContext context) {
    return S.of(context).buttonAdd;
  }

  static String buttonEdit(BuildContext context) {
    return S.of(context).buttonEdit;
  }

  static String buttonDelete(BuildContext context) {
    return S.of(context).buttonDelete;
  }

  static String buttonSave(BuildContext context) {
    return S.of(context).buttonSave;
  }

  static String buttonCancel(BuildContext context) {
    return S.of(context).buttonCancel;
  }

  static String buttonRetry(BuildContext context) {
    return S.of(context).buttonRetry;
  }

  static String buttonConfirm(BuildContext context) {
    return S.of(context).buttonConfirm;
  }

  static String buttonLogout(BuildContext context) {
    return S.of(context).buttonLogout;
  }

  // 获取确认对话框文本
  static String confirmDeleteTitle(BuildContext context) {
    return S.of(context).confirmDeleteTitle;
  }

  static String confirmDeleteMessage(BuildContext context) {
    return S.of(context).confirmDeleteMessage;
  }

  static String confirmLogoutTitle(BuildContext context) {
    return S.of(context).confirmLogoutTitle;
  }

  static String confirmLogoutMessage(BuildContext context) {
    return S.of(context).confirmLogoutMessage;
  }

  // 获取用户相关文本
  static String userName(BuildContext context) {
    return S.of(context).userName;
  }

  static String userEmail(BuildContext context) {
    return S.of(context).userEmail;
  }

  static String userPhone(BuildContext context) {
    return S.of(context).userPhone;
  }

  static String userCreatedAt(BuildContext context) {
    return S.of(context).userCreatedAt;
  }

  static String userUpdatedAt(BuildContext context) {
    return S.of(context).userUpdatedAt;
  }

  // 获取验证文本
  static String validationNameRequired(BuildContext context) {
    return S.of(context).validationNameRequired;
  }

  static String validationEmailRequired(BuildContext context) {
    return S.of(context).validationEmailRequired;
  }

  static String validationEmailInvalid(BuildContext context) {
    return S.of(context).validationEmailInvalid;
  }

  // 获取操作结果文本
  static String successUserAdded(BuildContext context) {
    return S.of(context).successUserAdded;
  }

  static String errorUserAddFailed(BuildContext context) {
    return S.of(context).errorUserAddFailed;
  }

  static String successUserUpdated(BuildContext context) {
    return S.of(context).successUserUpdated;
  }

  static String errorUserUpdateFailed(BuildContext context) {
    return S.of(context).errorUserUpdateFailed;
  }

  static String successUserDeleted(BuildContext context) {
    return S.of(context).successUserDeleted;
  }

  static String errorUserDeleteFailed(BuildContext context) {
    return S.of(context).errorUserDeleteFailed;
  }

  // 获取设置相关文本
  static String darkMode(BuildContext context) {
    return S.of(context).darkMode;
  }

  static String language(BuildContext context) {
    return S.of(context).language;
  }

  // 获取功能未实现文本
  static String editUserFunctionNotImplemented(BuildContext context) {
    return S.of(context).editUserFunctionNotImplemented;
  }

  static String themeSwitchFunctionNotImplemented(BuildContext context) {
    return S.of(context).themeSwitchFunctionNotImplemented;
  }

  static String settingsFunctionNotImplemented(BuildContext context) {
    return S.of(context).settingsFunctionNotImplemented;
  }

  static String changeAvatarFunctionNotImplemented(BuildContext context) {
    return S.of(context).changeAvatarFunctionNotImplemented;
  }

  static String editProfileFunctionNotImplemented(BuildContext context) {
    return S.of(context).editProfileFunctionNotImplemented;
  }

  static String accountSecurityFunctionNotImplemented(BuildContext context) {
    return S.of(context).accountSecurityFunctionNotImplemented;
  }

  static String notificationSettingsFunctionNotImplemented(BuildContext context) {
    return S.of(context).notificationSettingsFunctionNotImplemented;
  }

  static String logoutFunctionNotImplemented(BuildContext context) {
    return S.of(context).logoutFunctionNotImplemented;
  }
}