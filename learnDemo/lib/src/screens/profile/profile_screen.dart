import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/book_list.dart';
import '../storage_settings/storage_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _bookListNameController = TextEditingController();

  @override
  void dispose() {
    _bookListNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // 用户信息
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(userProvider.avatar),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          userProvider.username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '阅读爱好者',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StorageSettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 阅读统计
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '阅读统计',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                [
                  _buildStatItem(
                    '总阅读天数',
                    userProvider.totalReadingDays.toString(),
                  ),
                  _buildStatItem(
                    '总阅读时长',
                    '${userProvider.totalReadingHours}小时',
                  ),
                  _buildStatItem(
                    '读完书籍',
                    userProvider.booksRead.toString(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 我的书单
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  const Text(
                    '我的书单',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _showCreateBookListDialog(),
                  ),
                ],
              ),
            ),
            userProvider.bookLists.isEmpty
                ? _buildEmptyBookLists()
                : _buildBookLists(userProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children:
      [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyBookLists() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child:
      Center(
        child:
        Column(
          children:
          [
            Icon(
              Icons.list, 
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              '还没有创建书单',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookLists(UserProvider userProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userProvider.bookLists.length,
      itemBuilder: (context, index) {
        BookList bookList = userProvider.bookLists[index];
        return ListTile(
          leading: const Icon(Icons.list),
          title: Text(bookList.name),
          subtitle: Text('${bookList.bookCount}本书 · ${bookList.formattedCreateTime}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children:
            [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // 编辑书单
                },
                iconSize: 18,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('删除书单'),
                      content: const Text('确定要删除这个书单吗？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () {
                            userProvider.deleteBookList(bookList);
                            Navigator.pop(context);
                          },
                          child: const Text('确定'),
                        ),
                      ],
                    ),
                  );
                },
                iconSize: 18,
              ),
            ],
          ),
          onTap: () {
            // 打开书单详情
          },
        );
      },
    );
  }

  void _showCreateBookListDialog() {
    showDialog(
      context: context,
      builder: (context) {
        _bookListNameController.clear();
        return AlertDialog(
          title: const Text('创建书单'),
          content: TextField(
            controller: _bookListNameController,
            decoration: const InputDecoration(
              hintText: '请输入书单名称',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final name = _bookListNameController.text.trim();
                if (name.isNotEmpty) {
                  Provider.of<UserProvider>(context, listen: false).createBookList(name);
                  Navigator.pop(context);
                }
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}