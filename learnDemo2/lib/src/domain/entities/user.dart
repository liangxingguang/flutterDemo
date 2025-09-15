// 用户实体类

import 'package:hive/hive.dart';

part 'user.g.dart'; // 这将由Hive生成

@HiveType(typeId: 0) // 与适配器中的typeId一致
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String avatar;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.phone,
    required this.createdAt,
    this.updatedAt,
  });

  // 复制用户对象并更新部分属性
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ avatar.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }
}