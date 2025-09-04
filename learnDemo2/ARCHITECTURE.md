# MVVM + Repository 架构详解

本文档详细解释了本项目中使用的MVVM+Repository架构模式，包括各个层次的职责、它们之间的关系以及设计决策的理由。

## 什么是MVVM+Repository模式

MVVM (Model-View-ViewModel) 是一种架构模式，它将应用分为三个主要部分：
- **Model**: 数据模型和业务规则
- **View**: 用户界面和交互逻辑
- **ViewModel**: 连接Model和View，处理业务逻辑

Repository模式则是一种设计模式，它提供了一个抽象层，用于封装数据的获取和存储逻辑，使得应用的其他部分不需要关心数据的具体来源。

将这两种模式结合使用，可以创建一个高度模块化、易于测试和维护的应用架构。

## 项目架构图

```
+------------------+
| Presentation层   |
| (UI和状态管理)    |
|                  |
|  +------------+  |
|  |    Views   |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  | Controllers|  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |  Providers |  |
|  +------------+  |
+------------------+
         |
         v
+------------------+
|   Domain层       |
|  (业务逻辑核心)   |
|                  |
|  +------------+  |
|  |   UseCases |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |  Entities  |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |Repositories|
|  |  (接口)    |  |
|  +------------+  |
+------------------+
         |
         v
+------------------+
|    Data层        |
|  (数据访问实现)   |
|                  |
|  +------------+  |
|  |Repositories|
|  | (实现类)   |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |   Models   |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |   Local    |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |    API     |  |
|  +------------+  |
+------------------+
         |
         v
+------------------+
|  Infrastructure  |
|  (基础设施层)    |
|                  |
|  +------------+  |
|  |  Services  |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |  Config    |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |   Routes   |  |
|  +------------+  |
|        |         |
|  +------------+  |
|  |   Common   |  |
|  +------------+  |
+------------------+
```

## 各层详细说明

### 1. Infrastructure 层（基础设施层）

**职责**：
- 提供应用的基础功能和配置
- 实现横切关注点（如日志、配置、路由等）
- 不包含业务逻辑

**主要组件**：

#### Config
- 在`lib/src/config/`目录下
- 定义应用配置、主题配置等
- 示例：
```dart
// AppTheme示例
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    // 其他主题配置...
  );
  
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    // 其他主题配置...
  );
}
```

#### Routes
- 在`lib/src/routes/`目录下
- 定义应用路由配置
- 示例：
```dart
// AppRouter示例
class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // 其他路由配置...
      default:
        return _buildUnknownRoute(settings);
    }
  }
}
```

#### Common
- 在`lib/src/common/`目录下
- 包含常量、工具函数和扩展方法
- 示例：
```dart
// 常量示例
class AppConstants {
  static const String appName = 'Flutter MVVM + Repository Demo';
  static const String defaultAvatarUrl = 'https://picsum.photos/id/1005/200/200';
  // 其他常量...
}

// 工具函数示例
class CommonUtils {
  static void showSnackbar(BuildContext context, String message) {
    // 实现显示消息提示的逻辑
  }
  // 其他工具函数...
}
```

### 2. Data 层（数据访问实现层）

**职责**：
- 实现数据的获取和存储逻辑
- 封装与外部数据源的交互（API、数据库等）
- 实现Domain层定义的Repository接口

**主要组件**：

#### API
- 在`lib/src/api/`目录下
- 实现网络请求功能
- 示例：
```dart
// ApiClient示例
class ApiClient {
  final http.Client _client;
  final String _baseUrl;

  // 构造函数和请求方法...
  
  Future<Map<String, dynamic>> get(String endpoint) async {
    // 实现GET请求逻辑
  }
  
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    // 实现POST请求逻辑
  }
}

// 用户API服务示例
class UserApiService {
  final ApiClient _apiClient;
  
  Future<Map<String, dynamic>> getUsers() async {
    return await _apiClient.get('/users');
  }
  // 其他API方法...
}
```

#### Local
- 在`lib/src/data/local/`目录下
- 实现本地数据存储（如数据库、缓存等）
- 示例：
```dart
// User DAO示例
class UserDao {
  static const String boxName = 'users';
  late Box<User> _userBox;
  
  Future<void> init() async {
    _userBox = await Hive.openBox<User>(boxName);
  }
  
  Future<void> saveUser(User user) async {
    await _userBox.put(user.id, user);
  }
  // 其他DAO方法...
}
```

#### Models
- 在`lib/src/data/models/`目录下
- 定义数据模型，通常与API返回的数据结构对应
- 示例：
```dart
// UserModel示例
class UserModel {
  final int id;
  final String name;
  final String email;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  // 从JSON映射创建UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'] ?? '',
    );
  }

  // 转换为JSON映射
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}```

#### Repositories（实现类）
- 在`lib/src/data/repositories/`目录下
- 实现Domain层定义的Repository接口
- 负责协调本地数据和远程数据的交互
- 示例：
```dart
// UserRepositoryImpl示例
class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;
  final SharedPreferences? _sharedPreferences;

  UserRepositoryImpl({
    UserApiService? userApiService,
    SharedPreferences? sharedPreferences,
  }) : _userApiService = userApiService ?? UserApiService(),
       _sharedPreferences = sharedPreferences;

  // 获取用户列表
  @override
  Future<List<User>> getUsers() async {
    try {
      // 先尝试从缓存获取数据
      final cachedUsers = await _getCachedUsers();
      if (cachedUsers != null) {
        return cachedUsers;
      }

      // 缓存不存在或已过期，从API获取数据
      final response = await _userApiService.getUsers();
      final users = (response['data'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();

      // 缓存获取到的数据
      await _cacheUsers(users);

      return users;
    } catch (e) {
      print('获取用户列表失败: $e');
      // 如果网络请求失败，但有缓存数据，则返回缓存数据
      final cachedUsers = await _getCachedUsers();
      if (cachedUsers != null) {
        return cachedUsers;
      }
      rethrow;
    }
  }
  
  // 其他Repository方法的实现...
}```

### 3. Domain 层（业务逻辑核心层）

**职责**：
- 定义应用的核心业务逻辑和规则
- 不依赖于具体的技术实现（如UI框架、数据存储技术等）
- 是应用的核心，最稳定的部分

**主要组件**：

#### Entities（核心实体）
- 在`lib/src/domain/entities/`目录下
- 定义应用的核心业务实体
- 不依赖于任何外部层
- 示例：
```dart
// User实体示例
class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String? phone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.phone,
    required this.createdAt,
    this.updatedAt,
  });
  
  // 复制方法，用于更新实体的部分属性
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    // 实现复制逻辑...
  }
}
```

#### Repositories（接口）
- 在`lib/src/domain/repositories/`目录下
- 定义数据访问的抽象接口
- 使Domain层不依赖于具体的数据访问实现
- 示例：
```dart
// UserRepository接口示例
abstract class UserRepository {
  // 获取用户列表
  Future<List<User>> getUsers();

  // 根据ID获取单个用户
  Future<User> getUserById(int id);

  // 创建新用户
  Future<User> createUser(User user);

  // 更新用户信息
  Future<User> updateUser(User user);

  // 删除用户
  Future<bool> deleteUser(int id);
}```

#### UseCases（用例）
- 在`lib/src/domain/usecases/`目录下
- 封装单一的业务操作
- 协调多个Repository的调用以完成复杂的业务逻辑
- 示例：
```dart
// GetUsersUsecase示例
class GetUsersUsecase {
  final UserRepository _userRepository;

  // 依赖注入：通过构造函数接收Repository实例
  GetUsersUsecase(this._userRepository);

  // 执行用例
  Future<List<User>> execute() async {
    try {
      // 调用Repository获取用户列表
      return await _userRepository.getUsers();
    } catch (e) {
      // 可以在这里添加业务逻辑相关的错误处理
      print('获取用户列表用例执行失败: $e');
      rethrow;
    }
  }
}
```

### 4. Presentation 层（UI和状态管理层）

**职责**：
- 展示用户界面
- 处理用户交互
- 管理UI状态
- 连接用户界面和业务逻辑
- 支持多语言切换

**主要组件**：

#### Views (Screens/Widgets)
- 在`lib/src/presentation/screens/`和`lib/src/presentation/widgets/`目录下
- 定义用户界面的结构和外观
- 不包含业务逻辑
- 从Controllers或Providers获取数据并展示
- 示例：
```dart
// UserListScreen示例
class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // 在组件初始化时加载用户数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户列表')),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          // 处理加载状态
          if (provider.isLoading && provider.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 处理错误状态
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          // 显示用户列表
          return ListView.builder(
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];
              return UserCard(user: user);
            },
          );
        },
      ),
    );
  }
}
```

#### Providers
- 在`lib/src/presentation/providers/`目录下
- 实现状态管理逻辑
- 使用Provider模式连接UI和业务逻辑
- 示例：
```dart
// UserProvider示例
class UserProvider extends ChangeNotifier {
  // 依赖的用例
  final GetUsersUsecase _getUsersUsecase;
  final CreateUserUsecase _createUserUsecase;
  final DeleteUserUsecase _deleteUserUsecase;

  // 状态数据
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // 构造函数，接收用例实例
  UserProvider({
    GetUsersUsecase? getUsersUsecase,
    CreateUserUsecase? createUserUsecase,
    DeleteUserUsecase? deleteUserUsecase,
  }) : _getUsersUsecase = getUsersUsecase ?? GetUsersUsecase(null),
       _createUserUsecase = createUserUsecase ?? CreateUserUsecase(null),
       _deleteUserUsecase = deleteUserUsecase ?? DeleteUserUsecase(null);

  // 公开的getter方法，供View访问数据
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 加载用户列表
  Future<void> loadUsers() async {
    _setLoading(true);
    try {
      // 在实际项目中，这里应该调用用例获取数据
      // final users = await _getUsersUsecase.execute();
      // _users = users;
      
      // 模拟数据
      await Future.delayed(const Duration(seconds: 1));
      _users = _getMockUsers();
      _clearError();
    } catch (e) {
      _handleError('加载用户列表失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  // 添加用户
  Future<void> addUser(String name, String email, String? phone) async {
    // 实现添加用户逻辑...
  }

  // 删除用户
  Future<void> deleteUser(int id) async {
    // 实现删除用户逻辑...
  }

  // 内部方法：设置加载状态
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 内部方法：处理错误
  void _handleError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // 内部方法：清除错误信息
  void _clearError() {
    _errorMessage = null;
  }

  // 获取模拟用户数据
  List<User> _getMockUsers() {
    // 返回模拟用户数据...
  }
}
```

## 多语言支持实现

本项目使用Flutter的国际化机制实现了多语言支持，目前支持英语、简体中文和繁体中文三种语言，主要通过以下组件实现：

### 1. 本地化资源文件

- 在`lib/src/common/l10n/`目录下创建了ARB（Application Resource Bundle）文件
- 为每种支持的语言创建一个ARB文件（如`app_en.arb`、`app_zh.arb`和`app_zh_TW.arb`）
- ARB文件中定义了所有需要本地化的字符串键值对
- 对于中文，我们区分了简体中文(`zh`)和繁体中文(`zh_TW`)

### 2. 本地化代理

- 实现了`AppLocalizations`类，负责加载和提供本地化字符串
- 创建了`AppLocalizationsDelegate`类，用于Flutter框架识别和使用我们的本地化资源
- 提供了`AppLocalizationsDelegates`类，包含所有需要的本地化代理

### 3. 语言提供者

- 实现了`LanguageProvider`类，使用Provider模式管理当前选中的语言
- 支持从设备存储中保存和加载用户的语言偏好
- 提供了切换语言的方法，并通知UI更新

### 4. 在UI中使用本地化字符串

- 在Widget中通过`AppLocalizations.of(context)`获取本地化实例
- 使用本地化实例访问字符串资源，如`localizations?.pageTitleUserList ?? 'User List'`
- 为所有文本提供了默认值，确保即使本地化资源不可用也能正常显示

### 5. 多语言切换UI

- 创建设置页面，允许用户选择应用语言
- 使用`RadioListTile`组件显示所有支持的语言选项
- 通过`LanguageProvider`更新当前选中的语言

### 如何添加新语言

要为应用添加新的语言支持，请按照以下步骤操作：

1. **创建新的ARB文件**：
   - 在`lib/src/common/l10n/`目录下创建一个新的ARB文件，文件名格式为`app_{languageCode}.arb`或`app_{languageCode}_{countryCode}.arb`
   - 例如，要添加日语支持，可以创建`app_ja.arb`文件

2. **翻译字符串**：
   - 在新的ARB文件中，复制现有ARB文件的所有键，并提供相应语言的翻译
   - 确保保持键名一致，以保证应用能正确加载翻译

3. **更新支持的语言列表**：
   - 在`AppLocalizations`类的`supportedLocales`静态常量中添加新的语言代码
   - 例如，添加日语支持：`Locale('ja')`

4. **更新语言显示名称**：
   - 在`LanguageProvider`类的`getLanguageDisplayName`方法中添加新语言的显示名称
   - 确保为新语言提供用户友好的显示名称

5. **更新本地化加载逻辑**：
   - 在`AppLocalizations`类的`load`方法中添加新语言的字符串映射
   - 确保为每种新添加的语言提供完整的字符串集

通过这些步骤，您可以轻松地为应用添加新的语言支持，提高应用的国际化程度和用户体验。

## 使用MVVM+Repository模式的优势

1. **关注点分离**：每个组件都有明确的职责，使代码更易于理解和维护

2. **可测试性**：由于各层之间的依赖关系松散，可以轻松地为每个层编写单元测试

3. **可扩展性**：可以在不影响其他部分的情况下修改或替换任何一层

4. **UI与业务逻辑分离**：UI可以独立于业务逻辑变化，业务逻辑也可以独立于UI变化

5. **数据一致性**：Repository模式确保了数据的单一来源，减少了数据不一致的风险

## 实际项目中的最佳实践

1. **依赖注入**：使用构造函数注入依赖，而不是在类内部创建依赖实例，这样更容易测试

2. **错误处理**：在各个层次实现适当的错误处理，防止错误向上层扩散

3. **状态管理**：除了Provider，还可以考虑使用其他状态管理方案，如Riverpod、Bloc等

4. **缓存策略**：在Repository层实现适当的缓存策略，减少网络请求

5. **资源释放**：确保在组件销毁时释放所有资源，防止内存泄漏

## 总结

MVVM+Repository模式是一种强大的架构模式，特别适合于构建复杂的Flutter应用。通过将应用分为明确的层次，它使代码更易于组织、测试和维护。本项目展示了如何在实际应用中实现这种模式，并提供了一个简单但完整的示例，帮助初学者理解和掌握这种架构。