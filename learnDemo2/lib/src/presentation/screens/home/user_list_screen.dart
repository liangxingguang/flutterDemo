// 用户列表页面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user_card.dart';
import '../../widgets/add_user_dialog.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/extensions/context_extensions.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // 在组件初始化时加载用户数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.pageTitleUserList),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).loadUsers();
            },
            tooltip: context.localizations.buttonRefresh,
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            tooltip: context.localizations.pageTitleProfile,
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          // 处理加载状态
          if (provider.isLoading && provider.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 处理错误状态
          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Text(provider.errorMessage!),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadUsers();
                },
                child: Text(context.localizations.buttonRetry),
              ),
                ],
              ),
            );
          }

          // 处理空状态
          if (provider.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  const Icon(Icons.person_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(context.localizations.emptyText),
                  ElevatedButton(
                    onPressed: () => _showAddUserDialog(context),
                    child: Text(context.localizations.buttonAdd),
                  ),
                ],
              ),
            );
          }

          // 显示用户列表
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];
              return UserCard(
                user: user,
                onEdit: () => _showEditUserDialog(context, user),
                onDelete: () => _showDeleteConfirmation(context, user.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUserDialog(context),
        child: const Icon(Icons.add),
        tooltip: context.localizations.buttonAdd,
      ),
    );
  }

  // 显示添加用户对话框
  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddUserDialog(),
    );
  }

  // 显示编辑用户对话框
  void _showEditUserDialog(BuildContext context, dynamic user) {
    // 在实际项目中，这里应该跳转到编辑页面或显示编辑对话框
    CommonUtils.showSnackBar(
      context, 
      context.localizations.editUserFunctionNotImplemented
    );
  }

  // 显示删除确认对话框
  void _showDeleteConfirmation(BuildContext context, int userId) {
    CommonUtils.showConfirmationDialog(
      context, 
      context.localizations.confirmDeleteTitle, 
      context.localizations.confirmDeleteMessage,
    ).then((confirmed) {
      if (confirmed) {
        Provider.of<UserProvider>(context, listen: false).deleteUser(userId);
      }
    });
  }
}