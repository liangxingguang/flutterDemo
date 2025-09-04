import 'storage_service_interface.dart';
import 'hive_storage_service.dart';
import 'shared_preferences_storage_service.dart';

// 存储类型枚举
enum StorageType {
  hive,
  sharedPreferences,
}

// 存储服务工厂类，负责创建和管理存储服务实例
class StorageServiceFactory {
  // 单例模式
  static final StorageServiceFactory _instance = StorageServiceFactory._internal();
  factory StorageServiceFactory() => _instance;
  StorageServiceFactory._internal();

  // 当前使用的存储类型
  StorageType _currentStorageType = StorageType.hive;

  // 根据类型获取存储服务实例
  StorageServiceInterface getStorageService() {
    switch (_currentStorageType) {
      case StorageType.hive:
        return HiveStorageService();
      case StorageType.sharedPreferences:
        return SharedPreferencesStorageService();
      default:
        return HiveStorageService();
    }
  }

  // 设置当前使用的存储类型
  void setStorageType(StorageType type) {
    _currentStorageType = type;
  }

  // 获取当前存储类型
  StorageType get currentStorageType => _currentStorageType;
}