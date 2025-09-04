// 个人资料页面

import 'package:flutter/material.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.pageTitleProfile ?? 'Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              CommonUtils.showSnackbar(context, '设置功能尚未实现');
            },
            tooltip: localizations?.pageTitleSettings ?? 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // 用户头像
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(AppConstants.defaultAvatarUrl),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                        onPressed: () {
                          CommonUtils.showSnackbar(context, '更换头像功能尚未实现');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // 用户基本信息
            const Text(
              '管理员',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'admin@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            
            // 功能列表
            _buildProfileItem(
              context, 
              localizations?.personalInfo ?? 'Personal Information', 
              Icons.person, 
              () {
                CommonUtils.showSnackbar(context, '编辑个人信息功能尚未实现');
              }
            ),
            _buildProfileItem(
              context, 
              localizations?.accountSecurity ?? 'Account Security', 
              Icons.security, 
              () {
                CommonUtils.showSnackbar(context, '账号安全功能尚未实现');
              }
            ),
            _buildProfileItem(
              context, 
              localizations?.notificationSettings ?? 'Notification Settings', 
              Icons.notifications, 
              () {
                CommonUtils.showSnackbar(context, '通知设置功能尚未实现');
              }
            ),
            _buildProfileItem(
              context, 
              localizations?.pageTitleAbout ?? 'About Us', 
              Icons.info, 
              () {
                Navigator.pushNamed(context, '/about');
              }
            ),
            const SizedBox(height: 32),
            
            // 退出登录按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  CommonUtils.showConfirmationDialog(
                    context, 
                    localizations?.confirmLogoutTitle ?? 'Logout', 
                    localizations?.confirmLogoutMessage ?? 'Are you sure you want to logout?',
                  ).then((confirmed) {
                    if (confirmed) {
                      CommonUtils.showSnackbar(context, '退出登录功能尚未实现');
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(localizations?.buttonLogout ?? 'Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建个人资料列表项
  Widget _buildProfileItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}