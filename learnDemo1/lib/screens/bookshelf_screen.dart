import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';
import 'book_store_screen.dart';

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({super.key});

  @override
  State<BookshelfScreen> createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final bookshelf = bookProvider.bookshelf;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 顶部操作栏
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text(
                    '书架',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children:
                    [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const BookStoreScreen()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.file_open),
                        onPressed: () async {
                          await bookProvider.importLocalBook();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('书籍导入成功')),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(_isEditing ? Icons.done : Icons.edit),
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 书架内容
            Expanded(
              child: bookshelf.isEmpty
                  ? _buildEmptyBookshelf()
                  : _buildBookshelfGrid(bookProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyBookshelf() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          const Icon(
            Icons.bookmark_border,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '书架还是空的',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '从书城添加喜欢的书籍吧',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const BookStoreScreen()),
              );
            },
            child: const Text('前往书城'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookshelfGrid(BookProvider bookProvider) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.65,
      ),
      itemCount: bookProvider.bookshelf.length,
      itemBuilder: (context, index) {
        Book book = bookProvider.bookshelf[index];
        return GestureDetector(
          onTap: () {
            if (_isEditing) {
              // 编辑模式下长按移除
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('移除书籍'),
                  content: const Text('确定要从书架移除这本书吗？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    TextButton(
                      onPressed: () {
                        bookProvider.removeFromBookshelf(book);
                        Navigator.pop(context);
                      },
                      child: const Text('确定'),
                    ),
                  ],
                ),
              );
            } else {
              // 非编辑模式下点击阅读
              bookProvider.startReading(book);
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
              );
            }
          },
          child: Column(
            children:
            [
              Expanded(
                child: Stack(
                  children:
                  [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          book.coverUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}