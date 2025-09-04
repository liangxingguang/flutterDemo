import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import '../models/book_list.dart';
import 'dart:io';
import 'storage_service_interface.dart';

class SharedPreferencesStorageService implements StorageServiceInterface {
  // 保存书架信息
  Future<void> saveBookshelf(List<Book> books) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> booksJson = books.map((book) => book.toJson()).toList();
      await prefs.setString('bookshelf', json.encode(booksJson));
    } catch (e) {
      print('保存书架失败: $e');
    }
  }

  // 加载书架信息
  Future<List<Book>> loadBookshelf() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? booksJson = prefs.getString('bookshelf');
      if (booksJson != null) {
        List<dynamic> booksList = json.decode(booksJson);
        return booksList.map((item) => Book.fromJson(item)).toList();
      }
    } catch (e) {
      print('加载书架失败: $e');
    }
    return [];
  }

  // 保存阅读进度
  Future<void> saveReadingProgress(String bookId, double progress) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('reading_progress_$bookId', progress);
    } catch (e) {
      print('保存阅读进度失败: $e');
    }
  }

  // 加载阅读进度
  Future<double> loadReadingProgress(String bookId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getDouble('reading_progress_$bookId') ?? 0.0;
    } catch (e) {
      print('加载阅读进度失败: $e');
    }
    return 0.0;
  }

  // 保存用户信息
  Future<void> saveUserInfo(String username, String avatar) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('avatar', avatar);
    } catch (e) {
      print('保存用户信息失败: $e');
    }
  }

  // 加载用户信息
  Future<Map<String, String>> loadUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? '读书爱好者';
      String avatar = prefs.getString('avatar') ?? 'assets/images/user_avatar.png';
      return {'username': username, 'avatar': avatar};
    } catch (e) {
      print('加载用户信息失败: $e');
    }
    return {'username': '读书爱好者', 'avatar': 'assets/images/user_avatar.png'};
  }

  // 保存阅读统计
  Future<void> saveReadingStats(int totalReadingDays, int totalReadingHours, int booksRead) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('totalReadingDays', totalReadingDays);
      await prefs.setInt('totalReadingHours', totalReadingHours);
      await prefs.setInt('booksRead', booksRead);
    } catch (e) {
      print('保存阅读统计失败: $e');
    }
  }

  // 加载阅读统计
  Future<Map<String, int>> loadReadingStats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int totalReadingDays = prefs.getInt('totalReadingDays') ?? 0;
      int totalReadingHours = prefs.getInt('totalReadingHours') ?? 0;
      int booksRead = prefs.getInt('booksRead') ?? 0;
      return {
        'totalReadingDays': totalReadingDays,
        'totalReadingHours': totalReadingHours,
        'booksRead': booksRead
      };
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
  Future<void> saveBookLists(List<BookList> bookLists) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> listsJson = bookLists.map((list) => list.toJson()).toList();
      await prefs.setString('bookLists', json.encode(listsJson));
    } catch (e) {
      print('保存书单失败: $e');
    }
  }

  // 加载书单
  Future<List<BookList>> loadBookLists() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bookListsJson = prefs.getString('bookLists');
      if (bookListsJson != null) {
        List<dynamic> lists = json.decode(bookListsJson);
        return lists.map((item) => BookList.fromJson(item)).toList();
      }
    } catch (e) {
      print('加载书单失败: $e');
    }
    return [];
  }

  // 保存本地书籍文件路径
  Future<void> saveLocalBookPath(String bookId, String filePath) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_book_path_$bookId', filePath);
    } catch (e) {
      print('保存本地书籍路径失败: $e');
    }
  }

  // 加载本地书籍文件路径
  Future<String?> loadLocalBookPath(String bookId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('local_book_path_$bookId');
    } catch (e) {
      print('加载本地书籍路径失败: $e');
    }
    return null;
  }

  // 获取应用文档目录
  Future<Directory> getApplicationDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }
}