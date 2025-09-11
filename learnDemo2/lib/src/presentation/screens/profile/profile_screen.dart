// 个人资料页面

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/extensions/context_extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.pageTitleProfile),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
                CommonUtils.showSnackbar(
                  context,
                  context.localizations.settingsFunctionNotImplemented
                );
              },
            tooltip: context.localizations.pageTitleSettings,
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
                          CommonUtils.showSnackbar(
                            context,
                            context.localizations.changeAvatarFunctionNotImplemented
                          );
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
              context.localizations.personalInfo, 
              Icons.person, 
              () {
                CommonUtils.showSnackbar(
                  context,
                  context.localizations.editProfileFunctionNotImplemented
                );
              }
            ),
            _buildProfileItem(
              context, 
              context.localizations.accountSecurity, 
              Icons.security, 
              () {
                CommonUtils.showSnackbar(
                  context,
                  context.localizations.accountSecurityFunctionNotImplemented
                );
              }
            ),
            _buildProfileItem(
              context, 
              context.localizations.notificationSettings, 
              Icons.notifications, 
              () {
                CommonUtils.showSnackbar(
                  context,
                  context.localizations.notificationSettingsFunctionNotImplemented
                );
              }
            ),
            _buildProfileItem(
              context, 
              context.localizations.pageTitleAbout, 
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
                    context.localizations.confirmLogoutTitle, 
                    context.localizations.confirmLogoutMessage,
                  ).then((confirmed) {
                    if (confirmed) {
                        CommonUtils.showSnackbar(
                          context,
                          context.localizations.logoutFunctionNotImplemented
                        );
                      }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(context.localizations.buttonLogout),
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