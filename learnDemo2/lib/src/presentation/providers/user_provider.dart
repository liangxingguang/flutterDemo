// 用户状态管理

import 'package:flutter/foundation.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/entities/user.dart';
import '../../data/repositories/mock_user_repository.dart';

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
  }) : _getUsersUsecase = getUsersUsecase ?? GetUsersUsecase(MockUserRepository()),
       _createUserUsecase = createUserUsecase ?? CreateUserUsecase(MockUserRepository()),
       _deleteUserUsecase = deleteUserUsecase ?? DeleteUserUsecase(MockUserRepository());

  // 公开的getter方法，供View访问数据
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 加载用户列表
  Future<void> loadUsers() async {
    _setLoading(true);
    try {
      final users = await _getUsersUsecase.execute();
      _users = users;
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
      final newUser = await _createUserUsecase.execute(User(
        id: 0, // ID将由repository生成
        name: name,
        email: email,
        avatar: 'https://picsum.photos/id/${DateTime.now().millisecondsSinceEpoch % 1000}/200/200',
        phone: phone,
        createdAt: DateTime.now(),
      ));
      
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
      final success = await _deleteUserUsecase.execute(id);
      if (success) {
        _users.removeWhere((user) => user.id == id);
        _clearError();
        notifyListeners(); // 通知UI更新
      }
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


}