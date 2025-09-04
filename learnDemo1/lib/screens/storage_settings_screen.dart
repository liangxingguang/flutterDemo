import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/config_service.dart';
import '../services/storage_service_factory.dart';

class StorageSettingsScreen extends StatefulWidget {
  const StorageSettingsScreen({super.key});

  @override
  State<StorageSettingsScreen> createState() => _StorageSettingsScreenState();
}

class _StorageSettingsScreenState extends State<StorageSettingsScreen> {
  String? _currentStorageType;
  bool _isLoading = true;
  List<Map<String, String>> _storageOptions = [];

  @override
  void initState() {
    super.initState();
    _loadStorageOptions();
    _loadCurrentStorageType();
  }

  Future<void> _loadStorageOptions() async {
    _storageOptions = ConfigService.getAvailableStorageOptions();
  }

  Future<void> _loadCurrentStorageType() async {
    try {
      setState(() {
        _isLoading = true;
      });
      _currentStorageType = await ConfigService.getStorageType();
    } catch (e) {
      print('加载存储类型失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('加载存储类型失败')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _switchStorageType(String storageType) async {
    try {
      if (storageType == _currentStorageType) {
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      // 显示确认对话框
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('切换存储类型'),
          content: const Text('切换存储类型将重启应用以应用新的设置，确定要继续吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('确定'),
            ),
          ],
        ),
      );
      
      if (confirm == true) {
        // 保存配置
        await ConfigService.switchStorageType(storageType);
        
        // 显示提示并重启应用（在实际应用中，这里应该重启应用）
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('存储类型已切换，请重启应用以应用新设置')),
        );
        
        // 更新当前存储类型
        _currentStorageType = storageType;
      }
    } catch (e) {
      print('切换存储类型失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('切换存储类型失败')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('存储设置'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                children: [
                  // 存储类型选择
                  const Text(
                    '存储类型',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child:
                    Column(
                      children:
                      _storageOptions.map((option) {
                        bool isSelected = option['value'] == _currentStorageType;
                        return RadioListTile<String>(
                          title: Text(option['label']!),
                          subtitle: Text(option['description']!),
                          value: option['value']!,
                          groupValue: _currentStorageType,
                          onChanged: (value) {
                            if (value != null) {
                              _switchStorageType(value);
                            }
                          },
                          selected: isSelected,
                          activeColor: Colors.blue,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 存储信息
                  const Text(
                    '存储信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child:
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text(
                            '当前使用: ${_currentStorageType == ConfigService.hiveStorageType ? 'Hive 数据库' : 'SharedPreferences'}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '提示: 切换存储类型可能会影响应用性能和数据兼容性，请谨慎操作。',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}