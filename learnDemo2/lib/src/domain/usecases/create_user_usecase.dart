// 创建用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUserUsecase {
  final UserRepository _userRepository;

  CreateUserUsecase(this._userRepository);

  Future<User> execute(User user) async {
    try {
      // 参数验证
      if (user.name.isEmpty) {
        throw ArgumentError('用户名不能为空');
      }
      
      if (user.email.isEmpty || !user.email.contains('@')) {
        throw ArgumentError('请输入有效的邮箱地址');
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