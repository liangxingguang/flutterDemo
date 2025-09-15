// 设置页面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnDemo2/src/common/l10n/app_localizations.dart';
import '../../providers/language_provider.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/extensions/context_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.pageTitleSettings),
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
              title: Text(context.localizations.language),
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
              title: Text(context.localizations.darkMode),
              trailing: Switch.adaptive(
                value: MediaQuery.of(context).platformBrightness == Brightness.dark,
                onChanged: (value) {
                  final localizations = AppLocalizations.of(context);
                  CommonUtils.showSnackbar(
                    context,
                    localizations?.themeSwitchFunctionNotImplemented ?? 'Theme switch function not implemented'
                  );
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
              title: Text(context.localizations.pageTitleAbout),
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
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.localizations.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languageProvider.supportedLocales.map((locale) {
              final isSelected = locale == languageProvider.currentLocale;
              return RadioListTile<Locale>(
                title: Text(languageProvider.getLanguageDisplayNameDeprecated(locale)),
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