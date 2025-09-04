import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';
import 'book_store_screen.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 搜索栏
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '搜索书籍、作者',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            bookProvider.searchBooks(value);
                            setState(() {
                              _isSearching = true;
                            });
                          } else {
                            setState(() {
                              _isSearching = false;
                            });
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.shop, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const BookStoreScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 内容区域
            Expanded(
              child: _isSearching ? _buildSearchResults(bookProvider) : _buildRecommendedBooks(bookProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BookProvider bookProvider) {
    if (bookProvider.searchResults.isEmpty) {
      return const Center(
        child: Text('未找到相关书籍'),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.7,
      ),
      itemCount: bookProvider.searchResults.length,
      itemBuilder: (context, index) {
        Book book = bookProvider.searchResults[index];
        return _buildBookItem(context, book);
      },
    );
  }

  Widget _buildRecommendedBooks(BookProvider bookProvider) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const SizedBox(height: 8.0),
        const Text(
          '为你推荐',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.7,
          ),
          itemCount: bookProvider.recommendedBooks.length,
          itemBuilder: (context, index) {
            Book book = bookProvider.recommendedBooks[index];
            return _buildBookItem(context, book);
          },
        ),
      ],
    );
  }

  Widget _buildBookItem(BuildContext context, Book book) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bool isInBookshelf = bookProvider.bookshelf.contains(book);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      book.coverUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${book.rating}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
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
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}