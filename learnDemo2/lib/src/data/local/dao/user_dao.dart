// 用户数据访问对象（DAO）

import 'package:hive/hive.dart';
import '../../../domain/entities/user.dart';

class UserDao {
  static const String boxName = 'users';
  late Box<User> _userBox;

  // 初始化DAO
  Future<void> init() async {
    _userBox = await Hive.openBox<User>(boxName);
  }

  // 保存单个用户
  Future<void> saveUser(User user) async {
    await _userBox.put(user.id, user);
  }

  // 保存多个用户
  Future<void> saveUsers(List<User> users) async {
    final Map<int, User> userMap = {for (var user in users) user.id: user};
    await _userBox.putAll(userMap);
  }

  // 获取所有用户
  List<User> getAllUsers() {
    return _userBox.values.toList();
  }

  // 根据ID获取用户
  User? getUserById(int id) {
    return _userBox.get(id);
  }

  // 根据ID删除用户
  Future<void> deleteUser(int id) async {
    await _userBox.delete(id);
  }

  // 删除所有用户
  Future<void> deleteAllUsers() async {
    await _userBox.clear();
  }

  // 关闭Hive盒子
  Future<void> close() async {
    await _userBox.close();
  }
}