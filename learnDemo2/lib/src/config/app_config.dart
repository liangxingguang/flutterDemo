// 应用配置信息

class AppConfig {
  // 应用名称
  static const String appName = 'Flutter MVVM + Repository Demo';
  
  // 应用版本
  static const String appVersion = '1.0.0';
  
  // 构建号
  static const String buildNumber = '1';
  
  // API相关配置
  static const String baseUrl = 'https://api.example.com';
  static const int apiTimeout = 30; // 秒
  
  // 缓存配置
  static const String cacheDir = 'cache';
  static const int cacheMaxAge = 3600; // 秒
  
  // 调试模式
  static const bool debugMode = true;
  
  // 日志级别
  static const String logLevel = 'debug'; // debug, info, warn, error
  
  // 用户体验配置
  static const int defaultDebounceTime = 300; // 毫秒
  static const int splashScreenDuration = 2000; // 毫秒
}