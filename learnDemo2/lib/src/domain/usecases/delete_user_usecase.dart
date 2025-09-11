// 删除用户用例

import '../repositories/user_repository.dart';
import '../exceptions/app_exception.dart';

class DeleteUserUsecase {
  final UserRepository _userRepository;

  DeleteUserUsecase(this._userRepository);

  Future<bool> execute(int userId) async {
    try {
      // 参数验证
      if (userId <= 0) {
        throw ValidationException(
          code: AppErrorCode.userIdInvalid,
          message: 'User ID must be greater than 0',
          details: {'userId': userId},
        );
      }
      
      // 调用Repository删除用户
      return await _userRepository.deleteUser(userId);
    } catch (e) {
      print('删除用户用例执行失败: $e');
      rethrow;
    }
  }
}