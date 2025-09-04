import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/book_list.dart';
import '../services/storage_service_factory.dart';
import '../services/storage_service_interface.dart';

class UserProvider with ChangeNotifier {
  StorageServiceInterface _storageService;
  
  String _username = '读书爱好者';
  String _avatar = 'assets/images/user_avatar.png';
  int _totalReadingDays = 0;
  int _totalReadingHours = 0;
  int _booksRead = 0;
  List<BookList> _bookLists = [];

  String get username => _username;
  String get avatar => _avatar;
  int get totalReadingDays => _totalReadingDays;
  int get totalReadingHours => _totalReadingHours;
  int get booksRead => _booksRead;
  List<BookList> get bookLists => _bookLists;

  UserProvider() {
    // 从工厂获取存储服务实例
    _storageService = StorageServiceFactory().getStorageService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // 加载用户信息
    Map<String, String> userInfo = await _storageService.loadUserInfo();
    _username = userInfo['username'] ?? '读书爱好者';
    _avatar = userInfo['avatar'] ?? 'assets/images/user_avatar.png';
    
    // 加载阅读统计
    Map<String, int> stats = await _storageService.loadReadingStats();
    _totalReadingDays = stats['totalReadingDays'] ?? 0;
    _totalReadingHours = stats['totalReadingHours'] ?? 0;
    _booksRead = stats['booksRead'] ?? 0;

    // 加载书单
    _bookLists = await _storageService.loadBookLists();

    notifyListeners();
  }

  Future<void> _saveUserData() async {
    // 保存用户信息
    await _storageService.saveUserInfo(_username, _avatar);
    
    // 保存阅读统计
    await _storageService.saveReadingStats(
      _totalReadingDays, 
      _totalReadingHours, 
      _booksRead
    );

    // 保存书单
    await _storageService.saveBookLists(_bookLists);
  }

  void updateUserInfo({required String username, required String avatar}) {
    _username = username;
    _avatar = avatar;
    _saveUserData();
    notifyListeners();
  }

  void updateReadingStats(int days, int hours, int books) {
    _totalReadingDays += days;
    _totalReadingHours += hours;
    _booksRead += books;
    _saveUserData();
    notifyListeners();
  }

  void createBookList(String name) {
    BookList newList = BookList(
      id: 'list_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      books: [],
      createTime: DateTime.now(),
    );
    _bookLists.add(newList);
    _saveUserData();
    notifyListeners();
  }

  void addBookToBookList(BookList bookList, Book book) {
    if (!bookList.books.contains(book)) {
      bookList.books.add(book);
      _saveUserData();
      notifyListeners();
    }
  }

  void removeBookFromBookList(BookList bookList, Book book) {
    bookList.books.remove(book);
    _saveUserData();
    notifyListeners();
  }

  void deleteBookList(BookList bookList) {
    _bookLists.remove(bookList);
    _saveUserData();
    notifyListeners();
  }
}