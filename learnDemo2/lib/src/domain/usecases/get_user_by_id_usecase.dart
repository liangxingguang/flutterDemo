// 获取单个用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../exceptions/app_exception.dart';

class GetUserByIdUsecase {
  final UserRepository _userRepository;

  GetUserByIdUsecase(this._userRepository);

  Future<User> execute(int userId) async {
    try {
      // 参数验证
      if (userId <= 0) {
        throw ValidationException(
          code: AppErrorCode.userIdInvalid,
          message: 'User ID must be greater than 0',
          details: {'userId': userId},
        );
      }
      
      // 调用Repository获取用户详情
      final user = await _userRepository.getUserById(userId);
      
      // 检查用户是否存在
      if (user == null) {
        throw BusinessException(
          code: AppErrorCode.userNotFound,
          message: 'User not found',
          details: {'userId': userId},
        );
      }
      
      return user;
    } catch (e) {
      print('获取用户详情用例执行失败: $e');
      rethrow;
    }
  }
}