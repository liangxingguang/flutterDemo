import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/app.dart';
import 'src/services/config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化Hive
  try {
    await Hive.initFlutter();
    
    // 应用存储类型配置
    await ConfigService.applyStorageType();
    
    // 注册适配器 - 如果不使用代码生成器，需要手动注册
    // 注意：使用代码生成器后，这些适配器会在.g.dart文件中自动注册
    
    runApp(const App());
  } catch (e) {
    print('应用初始化失败: $e');
    // 即使初始化失败，也要运行应用
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('应用初始化失败，请重试'),
          ),
        ),
      ),
    );
  }
}