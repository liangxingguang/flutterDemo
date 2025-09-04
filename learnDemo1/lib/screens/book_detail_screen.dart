import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    bool isInBookshelf = bookProvider.bookshelf.contains(widget.book);

    return Scaffold(
      appBar: AppBar(
        title: const Text('书籍详情'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 书籍封面和基本信息
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.book.coverUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '作者：${widget.book.author}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '分类：${widget.book.category}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star, 
                              color: Colors.yellow,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.book.rating}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        if (isInBookshelf) {
                                          bookProvider.removeFromBookshelf(widget.book);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('已从书架移除')),
                                          );
                                        } else {
                                          bookProvider.addToBookshelf(widget.book);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('已添加到书架')),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isInBookshelf ? Colors.grey : Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(isInBookshelf ? '移出书架' : '加入书架'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // 开始阅读
                                  bookProvider.startReading(widget.book);
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => const ReadingPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('立即阅读'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 书籍简介
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const Text(
                    '内容简介',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      lineHeight: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // 目录预览（示例）
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const Text(
                    '目录预览',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('第${index + 1}章 示例章节'),
                        onTap: () {
                          // 跳转到对应章节
                          bookProvider.startReading(widget.book);
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const ReadingPage()),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 阅读页面（简化版）
class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // 点击显示/隐藏设置菜单
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24.0),
            child: const SingleChildScrollView(
              child: Text(
                '示例阅读内容...\n\n这里是书籍的内容，实际应用中会加载书籍的章节内容。\n\n通过上下滑动可以翻页，点击屏幕中央可以显示或隐藏阅读设置菜单。',
                style: TextStyle(
                  fontSize: 18,
                  lineHeight: 1.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}