import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/book.dart';
import '../models/book_list.dart';
import 'storage_service_interface.dart';

class HiveStorageService implements StorageServiceInterface {
  // 保存书架信息
  @override
  Future<void> saveBookshelf(List<Book> books) async {
    try {
      Box<Book> bookshelfBox = await Hive.openBox<Book>('bookshelf');
      await bookshelfBox.clear();
      await bookshelfBox.addAll(books);
      await bookshelfBox.close();
    } catch (e) {
      print('保存书架失败: $e');
    }
  }

  // 加载书架信息
  @override
  Future<List<Book>> loadBookshelf() async {
    try {
      Box<Book> bookshelfBox = await Hive.openBox<Book>('bookshelf');
      List<Book> books = bookshelfBox.values.toList();
      await bookshelfBox.close();
      return books;
    } catch (e) {
      print('加载书架失败: $e');
    }
    return [];
  }

  // 保存阅读进度
  @override
  Future<void> saveReadingProgress(String bookId, double progress) async {
    try {
      Box<double> progressBox = await Hive.openBox<double>('reading_progress');
      await progressBox.put(bookId, progress);
      await progressBox.close();
    } catch (e) {
      print('保存阅读进度失败: $e');
    }
  }

  // 加载阅读进度
  @override
  Future<double> loadReadingProgress(String bookId) async {
    try {
      Box<double> progressBox = await Hive.openBox<double>('reading_progress');
      double progress = progressBox.get(bookId, defaultValue: 0.0);
      await progressBox.close();
      return progress;
    } catch (e) {
      print('加载阅读进度失败: $e');
    }
    return 0.0;
  }

  // 保存用户信息
  @override
  Future<void> saveUserInfo(String username, String avatar) async {
    try {
      Box<Map<String, dynamic>> userBox = await Hive.openBox<Map<String, dynamic>>('user_info');
      await userBox.put('user', {'username': username, 'avatar': avatar});
      await userBox.close();
    } catch (e) {
      print('保存用户信息失败: $e');
    }
  }

  // 加载用户信息
  @override
  Future<Map<String, String>> loadUserInfo() async {
    try {
      Box<Map<String, dynamic>> userBox = await Hive.openBox<Map<String, dynamic>>('user_info');
      Map<String, dynamic>? userData = userBox.get('user');
      await userBox.close();
      
      if (userData != null) {
        return {
          'username': userData['username'] as String? ?? '读书爱好者',
          'avatar': userData['avatar'] as String? ?? 'assets/images/user_avatar.png'
        };
      }
    } catch (e) {
      print('加载用户信息失败: $e');
    }
    return {'username': '读书爱好者', 'avatar': 'assets/images/user_avatar.png'};
  }

  // 保存阅读统计
  @override
  Future<void> saveReadingStats(int totalReadingDays, int totalReadingHours, int booksRead) async {
    try {
      Box<Map<String, dynamic>> statsBox = await Hive.openBox<Map<String, dynamic>>('reading_stats');
      await statsBox.put('stats', {
        'totalReadingDays': totalReadingDays,
        'totalReadingHours': totalReadingHours,
        'booksRead': booksRead
      });
      await statsBox.close();
    } catch (e) {
      print('保存阅读统计失败: $e');
    }
  }

  // 加载阅读统计
  @override
  Future<Map<String, int>> loadReadingStats() async {
    try {
      Box<Map<String, dynamic>> statsBox = await Hive.openBox<Map<String, dynamic>>('reading_stats');
      Map<String, dynamic>? statsData = statsBox.get('stats');
      await statsBox.close();
      
      if (statsData != null) {
        return {
          'totalReadingDays': statsData['totalReadingDays'] as int? ?? 0,
          'totalReadingHours': statsData['totalReadingHours'] as int? ?? 0,
          'booksRead': statsData['booksRead'] as int? ?? 0
        };
      }
    } catch (e) {
      print('加载阅读统计失败: $e');
    }
    return {
      'totalReadingDays': 0,
      'totalReadingHours': 0,
      'booksRead': 0
    };
  }

  // 保存书单
  @override
  Future<void> saveBookLists(List<BookList> bookLists) async {
    try {
      Box<BookList> listsBox = await Hive.openBox<BookList>('book_lists');
      await listsBox.clear();
      await listsBox.addAll(bookLists);
      await listsBox.close();
    } catch (e) {
      print('保存书单失败: $e');
    }
  }

  // 加载书单
  @override
  Future<List<BookList>> loadBookLists() async {
    try {
      Box<BookList> listsBox = await Hive.openBox<BookList>('book_lists');
      List<BookList> bookLists = listsBox.values.toList();
      await listsBox.close();
      return bookLists;
    } catch (e) {
      print('加载书单失败: $e');
    }
    return [];
  }

  // 保存本地书籍文件路径
  @override
  Future<void> saveLocalBookPath(String bookId, String filePath) async {
    try {
      Box<String> localBooksBox = await Hive.openBox<String>('local_books');
      await localBooksBox.put(bookId, filePath);
      await localBooksBox.close();
    } catch (e) {
      print('保存本地书籍路径失败: $e');
    }
  }

  // 加载本地书籍文件路径
  @override
  Future<String?> loadLocalBookPath(String bookId) async {
    try {
      Box<String> localBooksBox = await Hive.openBox<String>('local_books');
      String? filePath = localBooksBox.get(bookId);
      await localBooksBox.close();
      return filePath;
    } catch (e) {
      print('加载本地书籍路径失败: $e');
    }
    return null;
  }
}