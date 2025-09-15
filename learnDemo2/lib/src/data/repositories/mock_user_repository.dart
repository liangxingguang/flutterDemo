import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  final List<User> _mockUsers = [
    User(
      id: 1,
      name: '张三',
      email: 'zhangsan@example.com',
      avatar: 'https://picsum.photos/id/1005/200/200',
      phone: '13800138001',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    User(
      id: 2,
      name: '李四',
      email: 'lisi@example.com',
      avatar: 'https://picsum.photos/id/1012/200/200',
      phone: '13800138002',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    User(
      id: 3,
      name: '王五',
      email: 'wangwu@example.com',
      avatar: 'https://picsum.photos/id/1025/200/200',
      phone: '13800138003',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockUsers);
  }

  @override
  Future<User> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = _mockUsers.firstWhere((user) => user.id == id);
    return user;
  }

  @override
  Future<User> createUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    final newUser = user.copyWith(
      id: DateTime.now().millisecondsSinceEpoch,
      createdAt: DateTime.now(),
    );
    _mockUsers.add(newUser);
    return newUser;
  }

  @override
  Future<User> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockUsers.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _mockUsers[index] = user.copyWith(
        updatedAt: DateTime.now(),
      );
      return _mockUsers[index];
    }
    throw Exception('用户不存在');
  }

  @override
  Future<bool> deleteUser(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    final initialLength = _mockUsers.length;
    _mockUsers.removeWhere((user) => user.id == id);
    return _mockUsers.length < initialLength;
  }
}