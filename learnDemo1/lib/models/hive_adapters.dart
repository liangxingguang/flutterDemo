import 'package:hive/hive.dart';
import 'book.dart';
import 'book_list.dart';

// Book适配器
class BookAdapter extends TypeAdapter<Book> {
  @override
  final typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final author = reader.readString();
    final coverUrl = reader.readString();
    final description = reader.readString();
    final category = reader.readString();
    final rating = reader.readDouble();
    final isInBookshelf = reader.readBool();

    return Book(
      id: id,
      title: title,
      author: author,
      coverUrl: coverUrl,
      description: description,
      category: category,
      rating: rating,
    )..isInBookshelf = isInBookshelf;
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.author);
    writer.writeString(obj.coverUrl);
    writer.writeString(obj.description);
    writer.writeString(obj.category);
    writer.writeDouble(obj.rating);
    writer.writeBool(obj.isInBookshelf);
  }
}

// BookList适配器
class BookListAdapter extends TypeAdapter<BookList> {
  @override
  final typeId = 1;

  @override
  BookList read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final books = reader.readList().cast<Book>();
    final createTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());

    return BookList(
      id: id,
      name: name,
      books: books,
      createTime: createTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookList obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeList(obj.books);
    writer.writeInt(obj.createTime.millisecondsSinceEpoch);
  }
}