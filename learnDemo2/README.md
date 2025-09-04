# Flutter MVVM + Repository 模式示例项目

本项目旨在帮助Flutter初学者快速理解和掌握MVVM (Model-View-ViewModel) 架构模式与Repository设计模式的结合使用。这是当前Flutter行业中主流的架构模式之一，能够有效分离关注点，提高代码的可维护性和可测试性。

## 项目目录结构

```
lib/
├── main.dart              # 应用入口
└── src/
    ├── api/               # 网络请求层
    │   ├── api_client.dart    # API客户端基础类
    │   └── services/          # 具体API服务
    ├── common/            # 公共类、常量、工具函数
    │   ├── constants/         # 常量定义
    │   ├── utils/             # 工具函数
    │   └── extensions/        # 扩展方法
    ├── data/              # 数据层
    │   ├── models/            # 数据模型
    │   ├── repositories/      # 数据仓库实现
    │   └── local/             # 本地数据存储
    │       ├── dao/           # 数据访问对象
    │       └── hive_adapters/ # Hive适配器
    ├── domain/            # 领域层（业务逻辑核心）
    │   ├── entities/          # 核心实体
    │   ├── usecases/          # 用例
    │   └── repositories/      # 领域仓库接口
    ├── presentation/      # 表现层（UI和状态管理）
    │   ├── screens/           # 页面
    │   │   ├── home/
    │   │   └── profile/
    │   ├── widgets/           # 可复用组件
    │   ├── providers/         # 状态管理
    │   └── controllers/       # 控制器（MVVM模式）
    ├── routes/            # 路由管理
    │   ├── app_router.dart    # 路由配置
    │   └── route_paths.dart   # 路由路径常量
    ├── services/          # 业务服务层
    │   ├── auth_service.dart  # 认证服务
    │   └── analytics_service.dart # 分析服务
    └── config/            # 应用配置
        ├── app_theme.dart     # 主题配置
        └── app_config.dart    # 应用配置
```

## 架构说明

### 1. Model 层
负责定义数据结构，通常是一些简单的POJO (Plain Old Java Object) 类，不包含业务逻辑。

### 2. Repository 层
作为数据的单一来源，封装了数据的获取和存储逻辑，负责协调本地数据和远程数据的交互。ViewModel不需要关心数据来自哪里，只需要通过Repository获取数据。

### 3. Service 层
具体实现数据的获取和存储，如API调用、数据库操作等。Repository通过Service获取或存储数据。

### 4. ViewModel 层
连接View和Model，处理业务逻辑，管理UI所需的状态数据，并提供数据绑定。ViewModel不依赖于特定的View实现，使得业务逻辑可以独立于UI变化。

### 5. View 层
用户界面，负责展示数据和处理用户交互。View通过观察者模式监听ViewModel中的数据变化，并根据变化更新UI。

## 本项目实现的功能

本项目实现了一个简单的用户列表管理应用，包括以下功能：

1. 获取用户列表（模拟网络请求）
2. 添加新用户
3. 删除用户
4. 更新用户信息

通过这些功能，展示了MVVM+Repository模式在实际项目中的应用方式。

## 如何运行项目

1. 确保已安装Flutter开发环境
2. 克隆或下载本项目
3. 在项目根目录执行 `flutter pub get` 安装依赖
4. 执行 `flutter run` 运行项目

## 学习资源

- [Flutter官方文档](https://flutter.dev/docs)
- [Provider状态管理](https://pub.dev/packages/provider)
- [Dart异步编程](https://dart.dev/codelabs/async-await)

## 注意事项

- 本项目使用Provider作为状态管理库，这是Flutter中实现MVVM模式的常用方式
- 为了简化，项目中使用了模拟数据和延迟操作来模拟网络请求
- 实际项目中，建议添加错误处理、日志记录等功能