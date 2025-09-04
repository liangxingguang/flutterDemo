// 用户API服务

import '../api_client.dart';

class UserApiService {
  final ApiClient _apiClient;

  UserApiService({ApiClient? apiClient}) 
      : _apiClient = apiClient ?? ApiClient();

  // 获取用户列表
  Future<Map<String, dynamic>> getUsers() async {
    try {
      return await _apiClient.get('/users');
    } catch (e) {
      print('获取用户列表失败: $e');
      rethrow;
    }
  }

  // 获取单个用户详情
  Future<Map<String, dynamic>> getUserById(int id) async {
    try {
      return await _apiClient.get('/users/$id');
    } catch (e) {
      print('获取用户详情失败: $e');
      rethrow;
    }
  }

  // 创建新用户
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      return await _apiClient.post('/users', body: userData);
    } catch (e) {
      print('创建用户失败: $e');
      rethrow;
    }
  }

  // 更新用户信息
  Future<Map<String, dynamic>> updateUser(int id, Map<String, dynamic> userData) async {
    try {
      return await _apiClient.put('/users/$id', body: userData);
    } catch (e) {
      print('更新用户失败: $e');
      rethrow;
    }
  }

  // 删除用户
  Future<Map<String, dynamic>> deleteUser(int id) async {
    try {
      return await _apiClient.delete('/users/$id');
    } catch (e) {
      print('删除用户失败: $e');
      rethrow;
    }
  }
}