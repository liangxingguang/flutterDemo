// 用户卡片组件

import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../common/l10n/app_localizations.dart';

class UserCard extends StatelessWidget {
  final dynamic user; // 在实际项目中，这里应该使用具体的User类型
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserCard({
    Key? key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Card(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children:
          [
            // 用户头像
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(user.avatar ?? 'https://picsum.photos/id/1005/200/200'),
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: 16),
            
            // 用户信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    user.name ?? (localizations?.unknownUser ?? 'Unknown User'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? (localizations?.unknownEmail ?? 'Unknown Email'),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  if (user.phone != null && user.phone!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      user.phone!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
            
            // 操作按钮
            Column(
              children:
              [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                  tooltip: localizations?.buttonEdit ?? 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: localizations?.buttonDelete ?? 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}