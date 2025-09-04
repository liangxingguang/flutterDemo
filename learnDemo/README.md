# Flutter 读书 App

这是一个参考微信读书App实现的Flutter阅读应用，提供了阅读、书架和个人中心功能。项目采用中型项目的结构设计，便于维护和扩展。

## 项目结构

项目采用模块化、分层的架构设计，遵循关注点分离原则，主要分为以下几个部分：

```
flutter_project/
├── android/           # Android平台相关代码
├── ios/               # iOS平台相关代码
├── lib/               # 主代码目录
│   ├── main.dart      # 应用入口
│   └── src/           # 源代码主目录
│       ├── app.dart   # 应用主组件
│       ├── config/    # 应用配置
│       ├── models/    # 数据模型
│       ├── providers/ # 状态管理
│       ├── routes/    # 路由管理
│       ├── screens/   # 页面组件
│       └── services/  # 业务服务
├── assets/            # 静态资源（图片、字体等）
├── test/              # 单元测试和Widget测试
├── pubspec.yaml       # 项目依赖配置
└── README.md          # 项目说明文档
```

### 目录详解

- **src/config/**: 包含应用的配置信息，如主题、环境变量等
- **src/models/**: 定义数据模型，如Book、BookList等
- **src/providers/**: 使用Provider进行状态管理
- **src/routes/**: 集中管理应用的路由配置
- **src/screens/**: 包含所有UI页面，按功能模块组织
- **src/services/**: 提供业务服务，如API调用、数据存储等

## 功能特点

### 阅读
- 为你推荐功能，展示精选书籍
- 书籍搜索功能
- 书城入口，可浏览和筛选各类书籍

### 书架
- 显示用户加入书架的书籍
- 支持从本地导入以及从书城添加书本
- 支持移除书架中的书籍

### 我的
- 显示用户基本信息
- 展示阅读统计数据（总阅读天数、时长、读完书籍数）
- 管理用户收藏和新建的书单
- 存储设置，可切换Hive和SharedPreferences

## 技术栈

- **Flutter**: 跨平台UI框架
- **Provider**: 状态管理
- **Hive**: 高性能NoSQL数据库
- **SharedPreferences**: 轻量级键值存储
- **http**: 网络请求
- **path_provider**: 文件路径管理
- **file_picker**: 文件选择

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

## 开发指南

### 环境搭建

1. 安装Flutter SDK: https://flutter.dev/docs/get-started/install
2. 克隆项目
3. 安装依赖：
   ```
   flutter pub get
   ```

### 生成Hive适配器文件

在运行应用前，需要先生成Hive的.g.dart文件：

```
flutter pub get
flutter packages pub run build_runner build
```

如果需要在每次修改模型类后自动生成，可以使用watch模式：

```
flutter packages pub run build_runner watch
```

### 运行应用

```
flutter run
```

## 项目规范

### 代码风格
- 遵循Dart官方推荐的代码风格
- 类名使用大驼峰命名法
- 方法和变量使用小驼峰命名法
- 常量使用全大写字母，单词之间用下划线分隔
- 缩进使用2个空格

### 命名规范
- 文件和目录名使用小写字母，单词之间用下划线分隔
- 组件名使用功能相关的描述性名称
- 状态管理类以Provider结尾
- 数据模型类直接使用业务名称

### 架构规范
- 遵循MVVM架构模式
- 业务逻辑与UI分离
- 使用Provider进行状态管理
- 数据访问通过Repository模式统一管理

### 分支管理
- main/master: 主分支，保持稳定版本
- develop: 开发分支，集成新功能
- feature/xxx: 特性分支，开发具体功能
- fix/xxx: 修复分支，修复bug

## 新手入门指南

### 项目启动流程

1. 应用从`main.dart`开始执行
2. 初始化Hive和存储配置
3. 创建Provider并运行应用
4. 根据路由配置显示对应页面

### 核心功能模块

#### 1. 阅读模块
- **ReadingScreen**: 显示推荐书籍和搜索功能
- **BookStoreScreen**: 显示书城和分类功能
- **BookDetailScreen**: 显示书籍详情和阅读入口

#### 2. 书架模块
- **BookshelfScreen**: 显示和管理书架书籍
- 支持添加、移除和导入书籍

#### 3. 个人中心模块
- **ProfileScreen**: 显示用户信息和阅读统计
- 支持创建和管理书单
- 存储设置功能

### 数据管理

- **BookProvider**: 管理书籍相关数据
- **UserProvider**: 管理用户相关数据
- **StorageService**: 管理数据持久化

### 常见问题

1. **如何添加新页面？**
   - 在`screens`目录下创建新文件夹和页面文件
   - 在`routes/app_router.dart`中添加路由配置

2. **如何添加新的数据模型？**
   - 在`models`目录下创建新的模型文件
   - 为模型类添加Hive注解
   - 运行`build_runner`生成适配器

3. **如何切换存储类型？**
   - 打开应用的"我的"页面
   - 点击设置图标
   - 选择"存储设置"
   - 选择所需的存储类型
   - 重启应用以应用新设置

## 版本历史

- v1.0.0: 初始版本，实现基本的阅读、书架和个人中心功能

## 作者信息

Flutter 学习团队

## 许可证

MIT License


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