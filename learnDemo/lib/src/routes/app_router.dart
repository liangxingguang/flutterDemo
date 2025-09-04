import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/reading/reading_screen.dart';
import '../screens/bookshelf/bookshelf_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/book_detail/book_detail_screen.dart';
import '../screens/book_store/book_store_screen.dart';
import '../screens/storage_settings/storage_settings_screen.dart';
import '../models/book.dart';

class AppRouter {
  // 路由路径常量
  static const String home = '/';
  static const String reading = '/reading';
  static const String bookshelf = '/bookshelf';
  static const String profile = '/profile';
  static const String bookDetail = '/bookDetail';
  static const String bookStore = '/bookStore';
  static const String storageSettings = '/storageSettings';

  // 路由生成器
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case reading:
        return MaterialPageRoute(builder: (_) => const ReadingScreen());
      
      case bookshelf:
        return MaterialPageRoute(builder: (_) => const BookshelfScreen());
      
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      
      case bookDetail:
        final Book book = settings.arguments as Book;
        return MaterialPageRoute(
          builder: (_) => BookDetailScreen(book: book),
        );
      
      case bookStore:
        return MaterialPageRoute(builder: (_) => const BookStoreScreen());
      
      case storageSettings:
        return MaterialPageRoute(builder: (_) => const StorageSettingsScreen());
      
      default:
        return _errorRoute();
    }
  }

  // 错误路由
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('错误'),
        ),
        body: const Center(
          child: Text('页面不存在'),
        ),
      );
    });
  }
}