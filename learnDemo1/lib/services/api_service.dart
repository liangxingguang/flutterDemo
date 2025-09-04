import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const String baseUrl = 'https://api.example.com'; // 实际项目中替换为真实API地址

  // 获取推荐书籍
  Future<List<Book>> getRecommendedBooks() async {
    try {
      // 在实际项目中，这里应该发送HTTP请求
      // final response = await http.get(Uri.parse('$baseUrl/books/recommended'));
      
      // 这里使用模拟数据，实际项目中应该解析API返回的数据
      return _getMockBooks();
    } catch (e) {
      print('获取推荐书籍失败: $e');
      // 出错时返回模拟数据
      return _getMockBooks();
    }
  }

  // 搜索书籍
  Future<List<Book>> searchBooks(String query) async {
    try {
      // 在实际项目中，这里应该发送HTTP请求
      // final response = await http.get(Uri.parse('$baseUrl/books/search?q=$query'));
      
      // 这里使用模拟数据，实际项目中应该解析API返回的数据
      List<Book> allBooks = _getMockBooks();
      return allBooks
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      print('搜索书籍失败: $e');
      // 出错时返回空列表
      return [];
    }
  }

  // 获取书籍详情
  Future<Book?> getBookDetail(String bookId) async {
    try {
      // 在实际项目中，这里应该发送HTTP请求
      // final response = await http.get(Uri.parse('$baseUrl/books/$bookId'));
      
      // 这里使用模拟数据，实际项目中应该解析API返回的数据
      List<Book> allBooks = _getMockBooks();
      return allBooks.firstWhere((book) => book.id == bookId);
    } catch (e) {
      print('获取书籍详情失败: $e');
      // 出错时返回null
      return null;
    }
  }

  // 获取模拟书籍数据
  List<Book> _getMockBooks() {
    return [
      Book(
        id: '1',
        title: '活着',
        author: '余华',
        coverUrl: 'assets/images/book1.jpg',
        description: '讲述了农村人福贵悲惨的人生遭遇。',
        category: '小说',
        rating: 4.8,
      ),
      Book(
        id: '2',
        title: '百年孤独',
        author: '加西亚·马尔克斯',
        coverUrl: 'assets/images/book2.jpg',
        description: '魔幻现实主义文学代表作。',
        category: '小说',
        rating: 4.9,
      ),
      Book(
        id: '3',
        title: '三体',
        author: '刘慈欣',
        coverUrl: 'assets/images/book3.jpg',
        description: '科幻文学作品，讲述人类文明与三体文明的接触。',
        category: '科幻',
        rating: 4.7,
      ),
      Book(
        id: '4',
        title: '解忧杂货店',
        author: '东野圭吾',
        coverUrl: 'assets/images/book4.jpg',
        description: '人与人之间的羁绊和温暖。',
        category: '小说',
        rating: 4.6,
      ),
    ];
  }
}