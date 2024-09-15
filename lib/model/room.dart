import 'package:spaa/model/user.dart';

class Room {
  final String id;
  final String name;
  final List<User> users;
  Room({required this.id, required this.name, required this.users});

  static fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'] as String,
      id: map['id'] as String,
      users: map['users'].map((userMap) => User.fromMap(userMap)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'users': users,
    };
  }
}
