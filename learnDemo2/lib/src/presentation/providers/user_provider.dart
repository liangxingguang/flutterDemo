// 用户状态管理

import 'package:flutter/foundation.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import '../../../domain/usecases/create_user_usecase.dart';
import '../../../domain/usecases/delete_user_usecase.dart';
import '../../../domain/entities/user.dart';

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
      // 注意：在实际项目中，这里需要提供正确的Repository实例
      // 由于我们是模拟环境，我们将使用模拟数据
      // 实际项目中应该是：final users = await _getUsersUsecase.execute();
      // 这里使用模拟数据
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
    _setLoading(true);
    try {
      // 注意：在实际项目中，这里需要提供正确的Repository实例
      // 由于我们是模拟环境，我们将创建一个模拟用户
      // 实际项目中应该是：
      // final newUser = await _createUserUsecase.execute(User(
      //   id: 0, // ID将由服务器生成
      //   name: name,
      //   email: email,
      //   avatar: 'https://picsum.photos/id/${DateTime.now().millisecondsSinceEpoch % 1000}/200/200',
      //   phone: phone,
      //   createdAt: DateTime.now(),
      // ));
      
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 创建模拟用户
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        email: email,
        avatar: 'https://picsum.photos/id/${DateTime.now().millisecondsSinceEpoch % 1000}/200/200',
        phone: phone,
        createdAt: DateTime.now(),
      );
      
      // 添加到列表
      _users.add(newUser);
      _clearError();
      notifyListeners(); // 通知UI更新
    } catch (e) {
      _handleError('添加用户失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  // 删除用户
  Future<void> deleteUser(int id) async {
    _setLoading(true);
    try {
      // 注意：在实际项目中，这里需要提供正确的Repository实例
      // 由于我们是模拟环境，我们将直接从列表中删除
      // 实际项目中应该是：final success = await _deleteUserUsecase.execute(id);
      
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 从列表中删除用户
      _users.removeWhere((user) => user.id == id);
      _clearError();
      notifyListeners(); // 通知UI更新
    } catch (e) {
      _handleError('删除用户失败: $e');
    } finally {
      _setLoading(false);
    }
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
    return [
      User(
        id: 1,
        name: '张三',
        email: 'zhangsan@example.com',
        avatar: 'https://picsum.photos/id/1005/200/200',
        phone: '13800138001',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      User(
        id: 2,
        name: '李四',
        email: 'lisi@example.com',
        avatar: 'https://picsum.photos/id/1012/200/200',
        phone: '13800138002',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      User(
        id: 3,
        name: '王五',
        email: 'wangwu@example.com',
        avatar: 'https://picsum.photos/id/1025/200/200',
        phone: '13800138003',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}