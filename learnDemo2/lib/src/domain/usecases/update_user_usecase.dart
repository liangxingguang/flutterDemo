// 更新用户用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository _userRepository;

  UpdateUserUsecase(this._userRepository);

  Future<User> execute(User user) async {
    try {
      // 参数验证
      if (user.id <= 0) {
        throw ArgumentError('用户ID必须大于0');
      }
      
      if (user.name.isEmpty) {
        throw ArgumentError('用户名不能为空');
      }
      
      if (user.email.isEmpty || !user.email.contains('@')) {
        throw ArgumentError('请输入有效的邮箱地址');
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