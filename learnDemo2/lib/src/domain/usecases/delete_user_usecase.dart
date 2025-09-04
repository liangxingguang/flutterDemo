// 删除用户用例

import '../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository _userRepository;

  DeleteUserUsecase(this._userRepository);

  Future<bool> execute(int userId) async {
    try {
      // 参数验证
      if (userId <= 0) {
        throw ArgumentError('用户ID必须大于0');
      }
      
      // 调用Repository删除用户
      return await _userRepository.deleteUser(userId);
    } catch (e) {
      print('删除用户用例执行失败: $e');
      rethrow;
    }
  }
}