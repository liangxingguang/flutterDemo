# Flutter 读书 App

这是一个参考微信读书App实现的Flutter阅读应用，提供了阅读、书架和个人中心功能。

## 功能特点

### 阅读
- 为你推荐功能，展示精选书籍
- 书籍搜索功能
- 书城入口，可浏览和筛选各类书籍

### 书架
- 显示用户加入书架的书籍
- 支持从本地导入书籍
- 支持从书城添加书籍
- 支持移除书架中的书籍

### 我的
- 显示用户基本信息
- 展示阅读统计数据（总阅读天数、时长、读完书籍数）
- 管理用户收藏和新建的书单

## 技术栈

- Flutter
- Provider 状态管理
- Hive 本地数据库
- FilePicker 文件选择
- http 网络请求

## 抽象存储层设计

项目实现了一个灵活的抽象存储层，使得业务逻辑不直接依赖于具体的存储实现。这一设计允许我们根据不同的数据特点和使用场景，灵活切换不同的存储方案。

### 核心组件

1. **存储接口 (`StorageServiceInterface`)**: 定义了所有存储操作的标准方法
2. **存储实现**: 
   - `HiveStorageService`: 基于Hive数据库的实现，适合复杂数据
   - `SharedPreferencesStorageService`: 基于SharedPreferences的实现，适合简单配置
3. **存储服务工厂 (`StorageServiceFactory`)**: 根据配置创建相应的存储实例
4. **配置服务 (`ConfigService`)**: 管理应用的存储设置

### 存储类型切换

用户可以通过应用内的"设置"页面（在"我的"页面中点击设置图标）切换存储类型：

- **Hive数据库**: 高性能NoSQL数据库，适合存储结构化数据和复杂对象
- **SharedPreferences**: 轻量级键值存储，适合存储简单配置项

### 生成Hive适配器文件

如果使用Hive作为存储方案，需要先生成Hive的.g.dart文件：

```
flutter pub get
flutter packages pub run build_runner build
```

如果需要在每次修改模型类后自动生成，可以使用watch模式：

```
flutter packages pub run build_runner watch
```

### 技术对比

| 特性 | SharedPreferences | Hive |
|------|------------------|------|
| 数据模型 | 简单键值存储 | NoSQL数据库 |
| 性能 | 一般 | 高性能（读取速度比SharedPreferences快3倍） |
| 数据复杂度 | 仅支持基本数据类型 | 支持复杂数据结构和对象 |
| 存储容量 | 有限 | 更大的存储容量 |
| 加密支持 | 不支持 | 支持 |
| 事务支持 | 不支持 | 支持 |
| 适用场景 | 少量简单数据，如配置项 | 大量结构化数据，如用户信息、业务数据 |

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── models/                   # 数据模型
│   ├── book.dart             # 书籍模型
│   └── book_list.dart        # 书单模型
├── providers/                # 状态管理
│   ├── book_provider.dart    # 书籍数据管理
│   └── user_provider.dart    # 用户数据管理
└── screens/                  # 页面
    ├── home_screen.dart      # 主页面（底部导航）
    ├── reading_screen.dart   # 阅读页面
    ├── bookshelf_screen.dart # 书架页面
    ├── profile_screen.dart   # 个人中心页面
    ├── book_detail_screen.dart # 书籍详情页面
    └── book_store_screen.dart # 书城页面
```

## 运行项目

确保已安装Flutter环境，然后运行以下命令：

```
flutter pub get
flutter run
```

## 注意事项

- 该项目使用了示例数据，实际使用时需要接入后端API
- 本地导入功能目前是模拟实现，实际项目中需要实现真实的文件导入和解析
- 阅读页面是简化版，实际项目中需要实现更复杂的阅读器功能