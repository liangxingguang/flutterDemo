// 应用路由配置

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../routes/route_paths.dart';
import '../presentation/screens/home/user_list_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';

class AppRouter {
  // 路由路径常量
  static const String homeRoute = RoutePaths.home;
  static const String userListRoute = RoutePaths.userList;
  static const String profileRoute = RoutePaths.profile;

  // 路由生成方法
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
      case userListRoute:
        return MaterialPageRoute(
          builder: (_) => const UserListScreen(),
          settings: settings,
        );
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
      case '/about':
        // 简单的关于页面
        return MaterialPageRoute(
          builder: (context) {
            final localizations = AppLocalizations.of(context);
            return Scaffold(
              appBar: AppBar(title: Text(localizations?.pageTitleAbout ?? 'About Us')),
              body: Center(
                child: Text(localizations?.appDescription ?? 'Flutter MVVM + Repository Demo App'),
              ),
            );
          },
          settings: settings,
        );
      default:
        // 处理未知路由
        return _buildUnknownRoute(settings);
    }
  }

  // 构建未知路由的页面
  static Route<dynamic> _buildUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        final localizations = AppLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations?.pageNotFound ?? 'Page Not Found'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${localizations?.pageNotFoundMessage ?? 'Cannot find page'}: ${settings.name}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  },
                  child: Text(localizations?.backToHome ?? 'Back to Home'),
                ),
              ],
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}