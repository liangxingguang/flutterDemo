// User Hive适配器

import 'package:hive/hive.dart';
import '../../../domain/entities/user.dart';

class UserHiveAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0; // 唯一的类型ID

  @override
  User read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final email = reader.readString();
    final avatar = reader.readString();
    final phone = reader.readString();
    final createdAt = reader.readString();
    final updatedAt = reader.readString();

    return User(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt.isNotEmpty ? DateTime.parse(updatedAt) : null,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.avatar);
    writer.writeString(obj.phone ?? '');
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.updatedAt?.toIso8601String() ?? '');
  }
}