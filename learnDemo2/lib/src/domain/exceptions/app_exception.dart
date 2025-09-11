// 应用自定义异常类

// 应用错误代码枚举
enum AppErrorCode {
  // 通用错误
  unknownError,
  networkError,
  serverError,
  timeoutError,
  unauthorizedError,
  forbiddenError,
  notFoundError,
  conflictError,
  validationError,
  
  // 用户相关错误
  userIdInvalid,
  userNameRequired,
  userEmailRequired,
  userEmailInvalid,
  userNotFound,
  userAlreadyExists,
  
  // 其他错误
  databaseError,
  cacheError,
  permissionDenied,
  resourceNotFound,
  serviceUnavailable,
  featureNotImplemented,
  invalidInput,
  operationFailed,
  internalError,
  clientError,
  serverMaintenance,
}

// 应用基础异常类
class AppException implements Exception {
  final AppErrorCode code;
  final String? message;
  final dynamic details;

  const AppException({
    required this.code,
    this.message,
    this.details,
  });

  @override
  String toString() {
    return 'AppException(code: $code, message: $message, details: $details)';
  }
}

// 参数验证异常
class ValidationException extends AppException {
  const ValidationException({
    required AppErrorCode code,
    String? message,
    dynamic details,
  }) : super(
          code: code,
          message: message ?? 'Validation error',
          details: details,
        );
}

// 网络异常
class NetworkException extends AppException {
  const NetworkException({
    required AppErrorCode code,
    String? message,
    dynamic details,
  }) : super(
          code: code,
          message: message ?? 'Network error',
          details: details,
        );
}

// 服务器异常
class ServerException extends AppException {
  const ServerException({
    required AppErrorCode code,
    String? message,
    dynamic details,
    int? statusCode,
  }) : super(
          code: code,
          message: message ?? 'Server error',
          details: {
            'statusCode': statusCode,
            'originalDetails': details,
          },
        );
}

// 授权异常
class AuthException extends AppException {
  const AuthException({
    required AppErrorCode code,
    String? message,
    dynamic details,
  }) : super(
          code: code,
          message: message ?? 'Authentication error',
          details: details,
        );
}

// 数据库异常
class DatabaseException extends AppException {
  const DatabaseException({
    required AppErrorCode code,
    String? message,
    dynamic details,
  }) : super(
          code: code,
          message: message ?? 'Database error',
          details: details,
        );
}

// 业务逻辑异常
class BusinessException extends AppException {
  const BusinessException({
    required AppErrorCode code,
    String? message,
    dynamic details,
  }) : super(
          code: code,
          message: message ?? 'Business logic error',
          details: details,
        );
}