// 用户仓库接口

import '../entities/user.dart';

// 领域仓库接口，定义了获取和操作用户数据的方法
// 这是领域层和数据层之间的抽象边界
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
}