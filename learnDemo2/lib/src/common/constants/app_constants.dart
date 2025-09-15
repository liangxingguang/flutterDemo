// 应用常量定义

class AppConstants {
  // 通用常量
  static const String defaultAvatarUrl = 'https://picsum.photos/id/1005/200/200';
  static const String noImageUrl = 'https://via.placeholder.com/200';
  
  // 日期格式常量
  static const String dateFormatStandard = 'yyyy-MM-dd';
  static const String dateTimeFormatStandard = 'yyyy-MM-dd HH:mm:ss';
  static const String timeFormatStandard = 'HH:mm:ss';
  
  // UI常量
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 8.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;
  static const double defaultIconSize = 24.0;
  
  // 缓存键名
  static const String cacheKeyUsers = 'users';
  static const String cacheKeyUserDetail = 'user_detail_';
  
  // 缓存时间（秒）
  static const int cacheMaxAge = 300; // 5分钟

  static const String defaultLanguageCodeEn = 'en';
  static const String defaultLanguageCodeZh = 'zh';

  static const String cacheDir = 'cache';

  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}