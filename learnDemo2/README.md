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

## 多语言支持

本项目使用Flutter官方的Flutter Intl插件实现多语言支持，支持英语、简体中文和繁体中文三种语言。

### 生成本地化文件

项目根目录下提供了生成脚本，用于生成本地化文件：

```bash
# Windows下运行
./generate_locales.bat

# Mac/Linux下运行
./generate_locales.sh  # 或直接运行命令
flutter pub global activate intl_utils
flutter pub get
flutter pub run intl_utils:generate
```

### 如何添加新的语言

1. 在`lib/src/common/l10n/`目录下创建新的ARB文件，文件名格式为`app_{languageCode}.arb`或`app_{languageCode}_{countryCode}.arb`
2. 复制`app_en.arb`文件的内容到新创建的文件中，并提供相应语言的翻译
3. 更新`l10n.yaml`文件中的`supported-locales`列表，添加新的语言代码
4. 运行生成脚本来生成本地化代码

### 如何在代码中使用本地化字符串

本项目提供了三种使用本地化字符串的方式：

#### 方式1: 使用原始的AppLocalizations

```dart
// 导入
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 获取实例
final localizations = AppLocalizations.of(context);

// 使用字符串
Text(localizations?.appName ?? 'Default Text');
```

#### 方式2: 使用Context扩展方法（推荐）

```dart
// 导入扩展
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../common/extensions/context_extensions.dart';

// 使用扩展方法
Text(context.localizations.appName);

// 或者使用更灵活的t方法
Text(context.t((l) => l.appName));
```

#### 方式3: 使用本地化常量助手（推荐）

```dart
// 导入扩展
import 'package:flutter/material.dart';
import '../common/extensions/context_extensions.dart';

// 使用常量助手
Text(context.consts.appName);
Text(context.consts.pageTitleUserList);
Text(context.consts.buttonAdd);
```

### 领域层异常处理

为了更好地处理业务逻辑错误并支持多语言，本项目实现了一套自定义异常体系：

1. **错误代码枚举** (`AppErrorCode`)：定义了所有可能的错误类型
2. **基础异常类** (`AppException`)：所有自定义异常的基类
3. **特定异常类**：`ValidationException`, `NetworkException`, `ServerException`等

#### 异常处理最佳实践

在业务逻辑中，应使用特定的异常类而不是硬编码的错误消息：

```dart
// 不推荐的做法
throw ArgumentError('用户名不能为空');

// 推荐的做法
throw ValidationException(
  code: AppErrorCode.userNameRequired,
  message: 'User name is required',
  details: {'field': 'name'},
);
```

在UI层，使用`ErrorMessageUtils`来显示本地化的错误消息：

```dart
try {
  // 调用用例
} catch (e) {
  ErrorMessageUtils.showErrorSnackbar(context, e);
}
```

### 本地化常量助手

为了方便访问常用的本地化文本，本项目提供了`LocalizedConstantsHelper`类，通过`context.consts`可以快速访问各种类型的本地化文本：

- **加载状态文本**: `context.consts.loadingText`, `context.consts.errorText`, `context.consts.emptyText`
- **页面标题**: `context.consts.pageTitleUserList`, `context.consts.pageTitleProfile`等
- **按钮文本**: `context.consts.buttonAdd`, `context.consts.buttonSave`等
- **确认对话框文本**: `context.consts.confirmDeleteTitle`, `context.consts.confirmDeleteMessage`等
- **用户相关文本**: `context.consts.userName`, `context.consts.userEmail`等
- **验证文本**: `context.consts.validationNameRequired`, `context.consts.validationEmailInvalid`等
- **操作结果文本**: `context.consts.successUserAdded`, `context.consts.errorUserAddFailed`等
- **设置相关文本**: `context.consts.darkMode`, `context.consts.language`等
- **功能未实现文本**: `context.consts.editUserFunctionNotImplemented`等

这种方式的优势是代码更简洁、更易于维护，并且提供了完整的类型安全。

### 项目配置

本项目的多语言配置位于`l10n.yaml`文件中：
```yaml
arb-dir: lib/src/common/l10n
# 模板文件
template-arb-file: intl_en.arb
# 支持的语言列表
supported-locales: [en, zh, zh_TW]
# 生成的文件名（带有.g.dart后缀表示自动生成的文件）
output-localization-file: app_localizations.g.dart
# 生成的类名
output-class: AppLocalizations
# 是否使用延迟加载
use-deferred-loading: false
```

## 注意事项

- 本项目使用Provider作为状态管理库，这是Flutter中实现MVVM模式的常用方式
- 为了简化，项目中使用了模拟数据和延迟操作来模拟网络请求
- 实际项目中，建议添加错误处理、日志记录等功能
- 多语言支持完全使用Flutter Intl插件自动生成代码，不需要手动维护本地化字符串类
- 添加新的本地化字符串后，只需更新ARB文件并重新运行生成脚本即可，无需手动修改代码