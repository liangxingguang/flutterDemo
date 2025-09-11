// 错误消息本地化工具类

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/exceptions/app_exception.dart';
import '../extensions/context_extensions.dart';

// 错误消息本地化工具类
class ErrorMessageUtils {
  // 私有构造函数，防止实例化
  ErrorMessageUtils._();

  // 根据错误代码获取本地化的错误消息
  static String getLocalizedErrorMessage(BuildContext context, AppException exception) {
    final localizations = context.localizations;

    switch (exception.code) {
      // 通用错误
      case AppErrorCode.unknownError:
        return localizations.errorText;
      case AppErrorCode.networkError:
        return '网络连接失败，请检查您的网络设置';
      case AppErrorCode.serverError:
        return '服务器错误，请稍后再试';
      case AppErrorCode.timeoutError:
        return '请求超时，请稍后再试';
      case AppErrorCode.unauthorizedError:
        return '您没有权限执行此操作';
      case AppErrorCode.forbiddenError:
        return '禁止访问';
      case AppErrorCode.notFoundError:
        return '请求的资源不存在';
      case AppErrorCode.conflictError:
        return '操作冲突，请稍后再试';
      case AppErrorCode.validationError:
        return '数据验证失败';
      
      // 用户相关错误
      case AppErrorCode.userIdInvalid:
        return localizations.validationNameRequired;
      case AppErrorCode.userNameRequired:
        return localizations.validationNameRequired;
      case AppErrorCode.userEmailRequired:
        return localizations.validationEmailRequired;
      case AppErrorCode.userEmailInvalid:
        return localizations.validationEmailInvalid;
      case AppErrorCode.userNotFound:
        return '用户不存在';
      case AppErrorCode.userAlreadyExists:
        return '用户已存在';
      
      // 其他错误
      case AppErrorCode.databaseError:
        return '数据库错误，请稍后再试';
      case AppErrorCode.cacheError:
        return '缓存错误，请稍后再试';
      case AppErrorCode.permissionDenied:
        return '权限被拒绝';
      case AppErrorCode.resourceNotFound:
        return '资源不存在';
      case AppErrorCode.serviceUnavailable:
        return '服务不可用，请稍后再试';
      case AppErrorCode.featureNotImplemented:
        return '功能尚未实现';
      case AppErrorCode.invalidInput:
        return '输入数据无效';
      case AppErrorCode.operationFailed:
        return '操作失败，请稍后再试';
      case AppErrorCode.internalError:
        return '内部错误，请稍后再试';
      case AppErrorCode.clientError:
        return '客户端错误';
      case AppErrorCode.serverMaintenance:
        return '服务器维护中，请稍后再试';
      
      default:
        return localizations.errorText;
    }
  }

  // 从异常中获取用户友好的错误消息
  static String getUserFriendlyErrorMessage(BuildContext context, Exception exception) {
    if (exception is AppException) {
      return getLocalizedErrorMessage(context, exception);
    }

    // 处理其他类型的异常
    if (exception is FormatException) {
      return '数据格式错误';
    } else if (exception is RangeError) {
      return '数据范围错误';
    } else if (exception is TypeError) {
      return '类型错误';
    } else if (exception is ArgumentError) {
      return exception.message?.toString() ?? '参数错误';
    } else {
      return context.localizations.errorText;
    }
  }

  // 显示错误消息Snackbar
  static void showErrorSnackbar(BuildContext context, Exception exception) {
    final message = getUserFriendlyErrorMessage(context, exception);
    CommonUtils.showSnackbar(context, message);
  }
}