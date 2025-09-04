import 'package:hive/hive.dart';
import 'storage_service_factory.dart';

class ConfigService {
  // 存储类型配置键
  static const String storageTypeKey = 'storage_type';
  static const String hiveStorageType = 'hive';
  static const String sharedPreferencesStorageType = 'shared_preferences';

  // 获取当前配置的存储类型
  static Future<String> getStorageType() async {
    try {
      Box<String> configBox = await Hive.openBox<String>('config');
      String storageType = configBox.get(storageTypeKey, defaultValue: hiveStorageType);
      await configBox.close();
      return storageType;
    } catch (e) {
      print('获取存储类型配置失败: $e');
      return hiveStorageType;
    }
  }

  // 保存存储类型配置
  static Future<void> saveStorageType(String storageType) async {
    try {
      Box<String> configBox = await Hive.openBox<String>('config');
      await configBox.put(storageTypeKey, storageType);
      await configBox.close();
    } catch (e) {
      print('保存存储类型配置失败: $e');
    }
  }

  // 应用存储类型配置
  static Future<void> applyStorageType() async {
    String storageType = await getStorageType();
    StorageServiceFactory storageFactory = StorageServiceFactory();
    
    if (storageType == sharedPreferencesStorageType) {
      storageFactory.setStorageType(StorageType.sharedPreferences);
    } else {
      storageFactory.setStorageType(StorageType.hive);
    }
  }

  // 切换存储类型
  static Future<void> switchStorageType(String storageType) async {
    await saveStorageType(storageType);
    await applyStorageType();
  }

  // 检查是否支持共享首选项
  static bool isSharedPreferencesSupported() {
    // 在实际应用中，可以根据平台或其他条件判断是否支持
    return true;
  }

  // 获取可用的存储选项
  static List<Map<String, String>> getAvailableStorageOptions() {
    return [
      {
        'value': hiveStorageType,
        'label': 'Hive 数据库',
        'description': '高性能 NoSQL 数据库，适合复杂数据'
      },
      {
        'value': sharedPreferencesStorageType,
        'label': 'SharedPreferences',
        'description': '轻量级键值存储，适合简单配置'
      }
    ];
  }
}