import '../models/book.dart';
import '../models/book_list.dart';

// 存储服务接口，定义所有存储操作的标准方法
abstract class StorageServiceInterface {
  // 书架相关操作
  Future<void> saveBookshelf(List<Book> books);
  Future<List<Book>> loadBookshelf();

  // 阅读进度相关操作
  Future<void> saveReadingProgress(String bookId, double progress);
  Future<double> loadReadingProgress(String bookId);

  // 用户信息相关操作
  Future<void> saveUserInfo(String username, String avatar);
  Future<Map<String, String>> loadUserInfo();

  // 阅读统计相关操作
  Future<void> saveReadingStats(int totalReadingDays, int totalReadingHours, int booksRead);
  Future<Map<String, int>> loadReadingStats();

  // 书单相关操作
  Future<void> saveBookLists(List<BookList> bookLists);
  Future<List<BookList>> loadBookLists();

  // 本地书籍相关操作
  Future<void> saveLocalBookPath(String bookId, String filePath);
  Future<String?> loadLocalBookPath(String bookId);
}