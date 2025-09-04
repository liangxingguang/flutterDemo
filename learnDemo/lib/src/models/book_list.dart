import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import './book.dart';

part 'book_list.g.dart';

@HiveType(typeId: 1)
class BookList extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  List<Book> books;
  @HiveField(3)
  final DateTime createTime;

  BookList({
    required this.id,
    required this.name,
    required this.books,
    required this.createTime,
  });

  factory BookList.fromJson(Map<String, dynamic> json) {
    List<dynamic> booksJson = json['books'] ?? [];
    List<Book> books = booksJson.map((bookJson) => Book.fromJson(bookJson)).toList();
    
    return BookList(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      books: books,
      createTime: DateTime.parse(json['createTime'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> booksJson = books.map((book) => book.toJson()).toList();
    
    return {
      'id': id,
      'name': name,
      'books': booksJson,
      'createTime': createTime.toIso8601String(),
    };
  }

  String get formattedCreateTime {
    return DateFormat('yyyy-MM-dd').format(createTime);
  }

  int get bookCount {
    return books.length;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookList && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}