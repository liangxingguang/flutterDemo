// 错误消息本地化工具类

import 'package:flutter/material.dart';
import '../../domain/exceptions/app_exception.dart';
import '../extensions/context_extensions.dart';
import 'common_utils.dart';

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
        return localizations.errorNetworkConnectionFailed;
      case AppErrorCode.serverError:
        return localizations.errorServerError;
      case AppErrorCode.timeoutError:
        return localizations.errorRequestTimeout;
      case AppErrorCode.unauthorizedError:
        return localizations.errorUnauthorized;
      case AppErrorCode.forbiddenError:
        return localizations.errorForbidden;
      case AppErrorCode.notFoundError:
        return localizations.errorNotFound;
      case AppErrorCode.conflictError:
        return localizations.errorConflict;
      case AppErrorCode.validationError:
        return localizations.errorValidationFailed;
      
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
        return localizations.errorUserNotFound;
      case AppErrorCode.userAlreadyExists:
        return localizations.errorUserAlreadyExists;
      
      // 其他错误
      case AppErrorCode.databaseError:
        return localizations.errorDatabaseError;
      case AppErrorCode.cacheError:
        return localizations.errorCacheError;
      case AppErrorCode.permissionDenied:
        return localizations.errorPermissionDenied;
      case AppErrorCode.resourceNotFound:
        return localizations.errorResourceNotFound;
      case AppErrorCode.serviceUnavailable:
        return localizations.errorServiceUnavailable;
      case AppErrorCode.featureNotImplemented:
        return localizations.errorFeatureNotImplemented;
      case AppErrorCode.invalidInput:
        return localizations.errorInvalidInput;
      case AppErrorCode.operationFailed:
        return localizations.errorOperationFailed;
      case AppErrorCode.internalError:
        return localizations.errorInternalError;
      case AppErrorCode.clientError:
        return localizations.errorClientError;
      case AppErrorCode.serverMaintenance:
        return localizations.errorServerMaintenance;
    }
  }

  // 从异常中获取用户友好的错误消息
  static String getUserFriendlyErrorMessage(BuildContext context, Exception exception) {
    if (exception is AppException) {
      return getLocalizedErrorMessage(context, exception);
    }

    final localizations = context.localizations;
    // 处理其他类型的异常
    if (exception is FormatException) {
      return localizations.errorDataFormatError;
    } else if (exception is RangeError) {
      return localizations.errorDataRangeError;
    } else if (exception is TypeError) {
      return localizations.errorTypeError;
    } else if (exception is ArgumentError) {
      return (exception as ArgumentError).message?.toString() ?? localizations.errorParameterError;
    } else {
      return localizations.errorText;
    }
  }

  // 显示错误消息SnackBar
  static void showErrorSnackBar(BuildContext context, Exception exception) {
    final message = getUserFriendlyErrorMessage(context, exception);
    CommonUtils.showSnackBar(context, message);
  }
}