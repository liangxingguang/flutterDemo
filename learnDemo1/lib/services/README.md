# 抽象存储层设计

本项目实现了一个抽象的存储层，使得业务层不直接依赖于具体的存储实现，从而可以根据实际需求灵活切换不同的存储方案。

## 设计思想

采用**依赖倒置原则**和**工厂模式**，通过接口定义存储操作，使用工厂类创建具体的存储实现。这样做的好处是：

1. **解耦**：业务代码不依赖具体的存储技术
2. **灵活性**：可以根据需求切换不同的存储实现
3. **可测试性**：方便进行单元测试和模拟测试
4. **扩展性**：易于添加新的存储实现

## 核心组件

### 1. 存储接口 (`StorageServiceInterface`)

定义了所有存储操作的标准方法，是抽象层的核心。所有存储实现都必须实现这个接口。

```dart
abstract class StorageServiceInterface {
  // 书架相关操作
  Future<void> saveBookshelf(List<Book> books);
  Future<List<Book>> loadBookshelf();
  
  // 更多方法...
}
```

### 2. 具体存储实现

- **HiveStorageService**：基于Hive数据库的实现
- **SharedPreferencesStorageService**：基于SharedPreferences的实现

### 3. 存储服务工厂 (`StorageServiceFactory`)

负责创建和管理存储服务实例，根据配置返回相应的存储实现。

```dart
StorageServiceInterface storageService = StorageServiceFactory().getStorageService();
```

### 4. 配置服务 (`ConfigService`)

管理应用的存储设置，支持在运行时切换存储类型。

```dart
// 保存存储类型配置
await ConfigService.saveStorageType(ConfigService.hiveStorageType);

// 应用存储类型配置
await ConfigService.applyStorageType();
```

## 使用方法

### 在Provider中使用

```dart
class BookProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  StorageServiceInterface _storageService;
  
  BookProvider() {
    // 从工厂获取存储服务实例
    _storageService = StorageServiceFactory().getStorageService();
  }
  
  // 使用存储服务...
}
```

### 切换存储类型

用户可以通过应用内的设置页面（`StorageSettingsScreen`）切换存储类型。

### 在应用启动时初始化

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化Hive
  await Hive.initFlutter();
  
  // 应用存储类型配置
  await ConfigService.applyStorageType();
  
  // 运行应用...
}
```

## 最佳实践

1. **选择合适的存储实现**：根据数据特点和使用场景选择合适的存储方案
2. **统一使用抽象接口**：业务代码只使用`StorageServiceInterface`接口，不直接引用具体实现
3. **合理配置存储类型**：在应用启动时应用存储配置，确保一致性
4. **考虑数据迁移**：在切换存储类型时，考虑数据迁移策略

## 扩展指南

要添加新的存储实现，只需：

1. 创建新的类并实现`StorageServiceInterface`接口
2. 在`StorageServiceFactory`中添加新的存储类型支持
3. 在`ConfigService`中添加新的配置选项

这样就可以在不修改业务代码的情况下，扩展新的存储能力。