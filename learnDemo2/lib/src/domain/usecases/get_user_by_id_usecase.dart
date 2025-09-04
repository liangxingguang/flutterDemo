// 获取单个用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserByIdUsecase {
  final UserRepository _userRepository;

  GetUserByIdUsecase(this._userRepository);

  Future<User> execute(int userId) async {
    try {
      // 参数验证
      if (userId <= 0) {
        throw ArgumentError('用户ID必须大于0');
      }
      
      // 调用Repository获取用户详情
      return await _userRepository.getUserById(userId);
    } catch (e) {
      print('获取用户详情用例执行失败: $e');
      rethrow;
    }
  }
}