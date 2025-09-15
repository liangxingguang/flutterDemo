import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnDemo2/src/common/l10n/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'src/config/app_theme.dart';
import 'src/presentation/providers/language_provider.dart';
import 'src/presentation/providers/user_provider.dart';
import 'src/routes/app_router.dart';

void main() {
  
  runApp(
    // 使用Provider包裹整个应用，提供全局状态管理
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取语言提供者
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      // 使用本地化的应用标题
      onGenerateTitle: (context) => S.of(context)?.appName ?? 'Flutter MVVM + Repository Demo',
      
      // 配置本地化代理和支持的语言
      localizationsDelegates:  const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: languageProvider.currentLocale,
      
      // 配置主题
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      // 配置路由
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.homeRoute,
    );
  }
}