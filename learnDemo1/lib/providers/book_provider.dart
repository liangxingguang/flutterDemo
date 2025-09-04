import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import '../services/storage_service_factory.dart';
import '../services/storage_service_interface.dart';

class BookProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  StorageServiceInterface _storageService;
  
  BookProvider() {
    // 从工厂获取存储服务实例
    _storageService = StorageServiceFactory().getStorageService();
  }
  
  List<Book> _bookshelf = [];
  List<Book> _recommendedBooks = [];
  List<Book> _searchResults = [];
  Book? _currentlyReadingBook;
  double _readingProgress = 0.0;

  List<Book> get bookshelf => _bookshelf;
  List<Book> get recommendedBooks => _recommendedBooks;
  List<Book> get searchResults => _searchResults;
  Book? get currentlyReadingBook => _currentlyReadingBook;
  double get readingProgress => _readingProgress;

  BookProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    // 加载推荐书籍
    _recommendedBooks = await _apiService.getRecommendedBooks();
    // 加载书架
    await _loadBookshelf();
    notifyListeners();
  }

  Future<void> _loadBookshelf() async {
    _bookshelf = await _storageService.loadBookshelf();
  }

  Future<void> _saveBookshelf() async {
    await _storageService.saveBookshelf(_bookshelf);
  }

  void addToBookshelf(Book book) {
    if (!_bookshelf.contains(book)) {
      _bookshelf.add(book);
      _saveBookshelf();
      notifyListeners();
    }
  }

  void removeFromBookshelf(Book book) {
    _bookshelf.remove(book);
    _saveBookshelf();
    notifyListeners();
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _recommendedBooks
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> importLocalBook() async {
    // 实际项目中需要实现文件选择功能
    // 这里仅作为示例添加一本本地书籍
    Book localBook = Book(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      title: '本地导入的书籍',
      author: '未知',
      coverUrl: 'assets/images/default_cover.jpg',
      description: '这是一本从本地导入的书籍。',
      category: '本地',
      rating: 0.0,
    );
    addToBookshelf(localBook);
  }

  void startReading(Book book) {
    _currentlyReadingBook = book;
    // 加载该书籍的阅读进度
    _loadReadingProgress(book.id);
    notifyListeners();
  }

  void updateReadingProgress(double progress) {
    _readingProgress = progress;
    if (_currentlyReadingBook != null) {
      _saveReadingProgress(_currentlyReadingBook!.id, progress);
    }
    notifyListeners();
  }

  Future<void> _loadReadingProgress(String bookId) async {
    _readingProgress = await _storageService.loadReadingProgress(bookId);
  }

  Future<void> _saveReadingProgress(String bookId, double progress) async {
    await _storageService.saveReadingProgress(bookId, progress);
  }

  // 搜索书籍（本地过滤）
  void searchBooks(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _recommendedBooks
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // 搜索书籍（从API）
  Future<void> searchBooksFromApi(String query) async {
    _searchResults = await _apiService.searchBooks(query);
    notifyListeners();
  }
}