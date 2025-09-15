// 获取用户列表用例

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../exceptions/app_exception.dart';

// 用例（UseCase）是领域层的核心组件，封装了单一的业务操作
// GetUsersUsecase负责获取用户列表的业务逻辑
class GetUsersUsecase {
  final UserRepository _userRepository;

  // 依赖注入：通过构造函数接收Repository实例
  GetUsersUsecase(this._userRepository);

  // 执行用例
  // 注意：这里我们将User实体转换为了UserRepository中定义的用户类型
  // 实际上，在完整实现中，我们可能需要添加映射逻辑来处理不同层的数据结构转换
  Future<List<User>> execute() async {
    try {
      // 调用Repository获取用户列表
      final users = await _userRepository.getUsers();
      
      // 返回用户列表
      return users;
    } catch (e) {
      // 添加更具体的错误处理逻辑
      print('获取用户列表用例执行失败: $e');
      
      // 如果是已有的AppException，直接抛出
      if (e is AppException) {
        rethrow;
      }
      
      // 将其他异常包装为AppException
      throw BusinessException(
        code: AppErrorCode.operationFailed,
        message: 'Failed to fetch users',
        details: {'originalError': e.toString()},
      );
    }
  }
}