// 设置页面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/l10n/generated/l10n.dart';
import '../../providers/language_provider.dart';

import 'language_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).pageTitleSettings),
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
              title: Text(S.of(context).language),
              subtitle: Text(languageProvider.getCurrentLanguageDisplayName(context)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSettingsScreen(),
                  ),
                );
              },
            ),
          ),
          
          // 主题设置
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(S.of(context).darkMode),
              trailing: Switch.adaptive(
                value: MediaQuery.of(context).platformBrightness == Brightness.dark,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).themeSwitchFunctionNotImplemented),
                    ),
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
              title: Text(S.of(context).pageTitleAbout),
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


}