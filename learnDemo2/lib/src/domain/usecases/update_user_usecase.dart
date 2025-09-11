// 更新用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../exceptions/app_exception.dart';

class UpdateUserUsecase {
  final UserRepository _userRepository;

  UpdateUserUsecase(this._userRepository);

  Future<User> execute(User user) async {
    try {
      // 参数验证
      if (user.id <= 0) {
        throw ValidationException(
          code: AppErrorCode.userIdInvalid,
          message: 'User ID must be greater than 0',
          details: {'userId': user.id},
        );
      }
      
      if (user.name.isEmpty) {
        throw ValidationException(
          code: AppErrorCode.userNameRequired,
          message: 'User name is required',
          details: {'field': 'name'},
        );
      }
      
      if (user.email.isEmpty) {
        throw ValidationException(
          code: AppErrorCode.userEmailRequired,
          message: 'Email is required',
          details: {'field': 'email'},
        );
      }
      
      if (!user.email.contains('@')) {
        throw ValidationException(
          code: AppErrorCode.userEmailInvalid,
          message: 'Invalid email format',
          details: {'field': 'email', 'value': user.email},
        );
      }
      
      // 添加更新时间
      final userToUpdate = user.copyWith(
        updatedAt: DateTime.now(),
      );
      
      // 调用Repository更新用户
      return await _userRepository.updateUser(userToUpdate);
    } catch (e) {
      print('更新用户用例执行失败: $e');
      rethrow;
    }
  }
}