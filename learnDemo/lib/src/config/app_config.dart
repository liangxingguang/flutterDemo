import 'package:flutter/material.dart';

// 应用配置类
class AppConfig {
  // 应用名称
  static const String appName = 'Flutter 读书';
  
  // 应用版本
  static const String appVersion = '1.0.0';
  
  // 构建号
  static const int buildNumber = 1;
  
  // 基础URL
  static const String baseUrl = 'https://api.example.com';
  
  // 是否为调试模式
  static const bool isDebugMode = true;
  
  // 默认主题
  static ThemeData get defaultTheme => ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'PingFang SC',
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      );
  
  // 深色主题
  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'PingFang SC',
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      );
  
  // 缓存大小限制（MB）
  static const int cacheSizeLimit = 100;
  
  // 页面加载超时时间（秒）
  static const int pageLoadTimeout = 30;
  
  // API请求超时时间（秒）
  static const int apiTimeout = 15;
  
  // 图片缓存策略
  static const bool enableImageCache = true;
  static const int imageCacheSize = 100;
  
  // 日志级别
  static const int logLevel = isDebugMode ? 2 : 0; // 0: 仅错误, 1: 警告, 2: 信息, 3: 调试
  
  // 隐私政策URL
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  
  // 用户协议URL
  static const String termsOfServiceUrl = 'https://example.com/terms';
}