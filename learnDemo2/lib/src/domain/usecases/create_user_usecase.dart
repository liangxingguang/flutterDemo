// 创建用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../exceptions/app_exception.dart';

class CreateUserUsecase {
  final UserRepository _userRepository;

  CreateUserUsecase(this._userRepository);

  Future<User> execute(User user) async {
    try {
      // 参数验证
      if (user.name.isEmpty) {
        throw ValidationException(
          code: AppErrorCode.userNameRequired,
          message: 'User name is required',
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
      
      // 添加创建时间
      final userToCreate = user.copyWith(
        createdAt: DateTime.now(),
      );
      
      // 调用Repository创建用户
      return await _userRepository.createUser(userToCreate);
    } catch (e) {
      print('创建用户用例执行失败: $e');
      rethrow;
    }
  }
}