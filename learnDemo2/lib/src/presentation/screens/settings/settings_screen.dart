// 设置页面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/utils/common_utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.pageTitleSettings ?? 'Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 语言设置
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(localizations?.language ?? 'Language'),
              subtitle: Text(languageProvider.currentLanguageDisplayName),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showLanguageSelectionDialog(context, languageProvider),
            ),
          ),
          
          // 主题设置
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(localizations?.darkMode ?? 'Dark Mode'),
              trailing: Switch.adaptive(
                value: MediaQuery.of(context).platformBrightness == Brightness.dark,
                onChanged: (value) {
                  CommonUtils.showSnackbar(context, '主题切换功能尚未实现');
                },
              ),
            ),
          ),
          
          // 关于我们
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(localizations?.pageTitleAbout ?? 'About Us'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ),
        ],
      ),
    );
  }

  // 显示语言选择对话框
  void _showLanguageSelectionDialog(BuildContext context, LanguageProvider languageProvider) {
    final localizations = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations?.language ?? 'Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languageProvider.supportedLocales.map((locale) {
              final isSelected = locale == languageProvider.currentLocale;
              return RadioListTile<Locale>(
                title: Text(languageProvider.getLanguageDisplayName(locale)),
                value: locale,
                groupValue: languageProvider.currentLocale,
                onChanged: (value) {
                  if (value != null) {
                    languageProvider.setLanguage(value);
                    Navigator.of(context).pop();
                  }
                },
                selected: isSelected,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}