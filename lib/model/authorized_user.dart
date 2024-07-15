class AuthorizedUser {
  final String name;
  final String accessId;
  final String id;

  AuthorizedUser(
      {required this.id, required this.name, required this.accessId});

  static fromMap(Map<String, dynamic> map) {
    return AuthorizedUser(
        name: map['name'] as String,
        accessId: map['AccessId'] as String,
        id: map['Id'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accessId': accessId,
      'id': id,
    };
  }
}
