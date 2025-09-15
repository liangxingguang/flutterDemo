import 'package:flutter/material.dart';
import '../../../common/l10n/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).language),
      ),
      body: ListView(
        children: [
          // 语言选择部分
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '选择语言',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          
          // 语言选项
          ...languageProvider.supportedLocales.map((locale) {
            final displayName = languageProvider.getLanguageDisplayName(context, locale);
            final isSelected = languageProvider.currentLocale == locale;
            
            return RadioListTile<Locale>(
              title: Text(displayName),
              value: locale,
              groupValue: languageProvider.currentLocale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  languageProvider.setLanguage(newLocale);
                }
              },
              secondary: isSelected 
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            );
          }).toList(),
          
          const Divider(),
          
          // 示例国际化字符串展示
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '示例',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                // 应用名称
                _buildExampleItem(
                  context,
                  'App Name',
                  S.of(context).appName,
                ),
                
                // 加载文本
                _buildExampleItem(
                  context,
                  'Loading',
                  S.of(context).loadingText,
                ),
                
                // 按钮文本
                _buildExampleItem(
                  context,
                  'Save Button',
                  S.of(context).buttonSave,
                ),
                
                // 错误消息
                _buildExampleItem(
                  context,
                  'Error Message',
                  S.of(context).errorText,
                ),
                
                // 空数据文本
                _buildExampleItem(
                  context,
                  'Empty',
                  S.of(context).emptyText,
                ),
                
                // 验证消息
                _buildExampleItem(
                  context,
                  'Validation',
                  S.of(context).validationEmailInvalid,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}