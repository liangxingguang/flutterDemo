# src 目录结构说明

本文档详细介绍Flutter读书应用`lib/src`目录下的代码结构，帮助开发者快速了解项目组织和功能模块划分。

## 目录概览

```
src/
├── app.dart           # 应用主组件，包含Provider配置
├── config/            # 应用配置
│   └── app_config.dart # 应用全局配置
├── models/            # 数据模型
│   ├── book.dart      # 书籍模型
│   └── book_list.dart # 书单模型
├── providers/         # 状态管理
│   ├── book_provider.dart  # 书籍相关状态管理
│   └── user_provider.dart  # 用户相关状态管理
├── routes/            # 路由管理
│   └── app_router.dart # 路由配置和生成
├── screens/           # 页面组件
│   ├── home/               # 主屏幕
│   │   └── home_screen.dart
│   ├── reading/            # 阅读相关页面
│   │   └── reading_screen.dart
│   ├── bookshelf/          # 书架相关页面
│   │   └── bookshelf_screen.dart
│   ├── profile/            # 个人中心相关页面
│   │   └── profile_screen.dart
│   ├── book_detail/        # 书籍详情相关页面
│   │   └── book_detail_screen.dart
│   ├── book_store/         # 书城相关页面
│   │   └── book_store_screen.dart
│   └── storage_settings/   # 存储设置相关页面
│       └── storage_settings_screen.dart
└── services/          # 业务服务
    ├── api_service.dart             # API服务
    ├── config_service.dart          # 配置服务
    ├── hive_storage_service.dart    # Hive存储服务
    ├── shared_preferences_storage_service.dart # SharedPreferences存储服务
    ├── storage_service_interface.dart # 存储服务接口
    └── storage_service_factory.dart # 存储服务工厂
```

## 详细说明

### 1. app.dart

应用的主组件，负责初始化Provider并创建MaterialApp。这是应用的核心入口组件，将所有功能模块整合在一起。

### 2. config/

存放应用的全局配置，包括主题、环境变量、常量等。

- **app_config.dart**: 定义应用的基本配置，如主题样式、应用名称、版本号等。

### 3. models/

定义应用中使用的所有数据模型，用于数据的结构化表示和传递。

- **book.dart**: 书籍数据模型，包含书籍的基本信息。
- **book_list.dart**: 书单数据模型，用于管理用户创建的书单。

### 4. providers/

使用Provider模式进行状态管理，分离业务逻辑和UI。

- **book_provider.dart**: 管理书籍相关的状态，如推荐书籍、书架、阅读进度等。
- **user_provider.dart**: 管理用户相关的状态，如用户信息、阅读统计、书单等。

### 5. routes/

集中管理应用的路由配置，实现页面之间的导航。

- **app_router.dart**: 定义应用的所有路由，并实现路由生成器。

### 6. screens/

包含应用的所有UI页面，按功能模块组织。

- **home/**: 主屏幕，包含底部导航栏。
- **reading/**: 阅读相关页面，包括书籍推荐和搜索。
- **bookshelf/**: 书架相关页面，用于管理用户的书籍。
- **profile/**: 个人中心相关页面，显示用户信息和统计。
- **book_detail/**: 书籍详情相关页面，显示书籍详细信息。
- **book_store/**: 书城相关页面，用于浏览和搜索书籍。
- **storage_settings/**: 存储设置相关页面，用于切换存储类型。

### 7. services/

提供各种业务服务，如API调用、数据存储等。

- **api_service.dart**: 处理网络请求，与后端API交互。
- **config_service.dart**: 管理应用的配置信息。
- **hive_storage_service.dart**: 基于Hive数据库的存储实现。
- **shared_preferences_storage_service.dart**: 基于SharedPreferences的存储实现。
- **storage_service_interface.dart**: 定义存储服务的接口。
- **storage_service_factory.dart**: 根据配置创建相应的存储服务实例。

## 核心功能模块

### 阅读模块

- **ReadingScreen**: 显示为你推荐的书籍，提供搜索功能和书城入口。
- **BookStoreScreen**: 显示书城，支持按分类浏览和搜索书籍。
- **BookDetailScreen**: 显示书籍的详细信息，提供加入书架和立即阅读功能。

### 书架模块

- **BookshelfScreen**: 显示用户添加到书架的书籍，支持导入本地书籍和管理书架。

### 个人中心模块

- **ProfileScreen**: 显示用户信息、阅读统计和书单管理。
- **StorageSettingsScreen**: 提供存储类型切换功能。

## 技术栈

- **Provider**: 状态管理
- **Hive**: 高性能NoSQL数据库
- **SharedPreferences**: 轻量级键值存储
- **http**: 网络请求
- **MaterialApp**: UI框架

## 新手入门指南

### 1. 理解项目流程

1. 应用从`main.dart`开始，初始化Hive和配置
2. 加载`App`组件，初始化Provider
3. 根据路由配置显示对应页面
4. 通过Provider管理状态和数据

### 2. 添加新功能

1. **添加新页面**: 
   - 在`screens`目录下创建新文件夹和页面文件
   - 在`routes/app_router.dart`中添加路由配置

2. **添加新数据模型**: 
   - 在`models`目录下创建新的模型文件
   - 为模型类添加Hive注解
   - 运行`build_runner`生成适配器

3. **添加新服务**: 
   - 在`services`目录下创建新的服务文件
   - 如果是存储服务，实现`StorageServiceInterface`接口

### 3. 数据流向

- UI组件通过Provider获取数据
- 用户操作触发Provider中的方法
- Provider更新状态并通知UI刷新
- 数据持久化通过StorageService实现

### 4. 常见问题

- **数据不更新**: 检查Provider是否正确通知了变化（调用notifyListeners()）
- **存储问题**: 检查是否正确初始化了Hive或SharedPreferences
- **路由问题**: 检查路由配置是否正确，参数是否正确传递

通过遵循以上结构和规范，可以有效地组织和扩展Flutter读书应用的功能。