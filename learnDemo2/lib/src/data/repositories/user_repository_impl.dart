// 用户数据仓库实现

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../api/services/user_api_service.dart';
import '../models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../../common/constants/app_constants.dart';
import '../../domain/entities/user.dart';

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
        return cachedUsers.map((model) => model.toEntity()).toList();
      }

      // 缓存不存在或已过期，从API获取数据
      final response = await _userApiService.getUsers();
      final users = (response['data'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .map((model) => model.toEntity())
          .toList();

      // 缓存获取到的数据
      await _cacheUsers((response['data'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList());

      return users;
    } catch (e) {
      print('获取用户列表失败: $e');
      // 如果网络请求失败，但有缓存数据，则返回缓存数据
      final cachedUsers = await _getCachedUsers();
      if (cachedUsers != null) {
        return cachedUsers.map((model) => model.toEntity()).toList();
      }
      rethrow;
    }
  }

  // 获取单个用户
  @override
  Future<User> getUserById(int id) async {
    try {
      // 先尝试从缓存获取数据
      final cachedUser = await _getCachedUser(id);
      if (cachedUser != null) {
        return cachedUser.toEntity();
      }

      // 缓存不存在或已过期，从API获取数据
      final response = await _userApiService.getUserById(id);
      final user = UserModel.fromJson(response['data']);

      // 缓存获取到的数据
      await _cacheUser(user);

      return user.toEntity();
    } catch (e) {
      print('获取用户详情失败: $e');
      // 如果网络请求失败，但有缓存数据，则返回缓存数据
      final cachedUser = await _getCachedUser(id);
      if (cachedUser != null) {
        return cachedUser.toEntity();
      }
      rethrow;
    }
  }

  // 创建新用户
  @override
  Future<User> createUser(User user) async {
    try {
      final response = await _userApiService.createUser(UserModel.fromEntity(user).toJson());
      final createdUser = UserModel.fromJson(response['data']);

      // 更新缓存
      await _invalidateUsersCache();

      return createdUser.toEntity();
    } catch (e) {
      print('创建用户失败: $e');
      rethrow;
    }
  }

  // 更新用户
  @override
  Future<User> updateUser(User user) async {
    try {
      final response = await _userApiService.updateUser(user.id, UserModel.fromEntity(user).toJson());
      final updatedUser = UserModel.fromJson(response['data']);

      // 更新缓存
      await _invalidateUsersCache();
      await _cacheUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      print('更新用户失败: $e');
      rethrow;
    }
  }

  // 删除用户
  @override
  Future<bool> deleteUser(int id) async {
    try {
      final response = await _userApiService.deleteUser(id);
      final success = response['success'] ?? false;

      if (success) {
        // 更新缓存
        await _invalidateUsersCache();
        await _removeCachedUser(id);
      }

      return success;
    } catch (e) {
      print('删除用户失败: $e');
      rethrow;
    }
  }

  // 缓存用户列表
  Future<void> _cacheUsers(List<UserModel> users) async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      final usersJson = json.encode(users.map((user) => user.toJson()).toList());
      await prefs.setString(AppConstants.cacheKeyUsers, usersJson);
      await prefs.setInt('${AppConstants.cacheKeyUsers}_timestamp', 
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('缓存用户列表失败: $e');
    }
  }

  // 从缓存获取用户列表
  Future<List<UserModel>?> _getCachedUsers() async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      final usersJson = prefs.getString(AppConstants.cacheKeyUsers);
      final timestamp = prefs.getInt('${AppConstants.cacheKeyUsers}_timestamp');

      // 检查缓存是否存在且未过期
      if (usersJson == null || timestamp == null) {
        return null;
      }

      // 检查缓存是否过期（这里使用简单的时间检查，实际项目中可以使用更复杂的策略）
      final now = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = now - timestamp;
      if (cacheAge > AppConstants.cacheMaxAge * 1000) {
        return null;
      }

      final usersList = json.decode(usersJson) as List;
      return usersList.map((userJson) => UserModel.fromJson(userJson)).toList();
    } catch (e) {
      print('获取缓存用户列表失败: $e');
      return null;
    }
  }

  // 缓存单个用户
  Future<void> _cacheUser(UserModel user) async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString('${AppConstants.cacheKeyUserDetail}${user.id}', userJson);
      await prefs.setInt('${AppConstants.cacheKeyUserDetail}${user.id}_timestamp', 
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('缓存用户详情失败: $e');
    }
  }

  // 从缓存获取单个用户
  Future<UserModel?> _getCachedUser(int id) async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      final userJson = prefs.getString('${AppConstants.cacheKeyUserDetail}$id');
      final timestamp = prefs.getInt('${AppConstants.cacheKeyUserDetail}${id}_timestamp');

      // 检查缓存是否存在且未过期
      if (userJson == null || timestamp == null) {
        return null;
      }

      // 检查缓存是否过期
      final now = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = now - timestamp;
      if (cacheAge > AppConstants.cacheMaxAge * 1000) {
        return null;
      }

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      print('获取缓存用户详情失败: $e');
      return null;
    }
  }

  // 移除缓存的单个用户
  Future<void> _removeCachedUser(int id) async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      await prefs.remove('${AppConstants.cacheKeyUserDetail}$id');
      await prefs.remove('${AppConstants.cacheKeyUserDetail}${id}_timestamp');
    } catch (e) {
      print('移除缓存用户详情失败: $e');
    }
  }

  // 使用户列表缓存失效
  Future<void> _invalidateUsersCache() async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.cacheKeyUsers);
      await prefs.remove('${AppConstants.cacheKeyUsers}_timestamp');
    } catch (e) {
      print('使缓存失效失败: $e');
    }
  }
}