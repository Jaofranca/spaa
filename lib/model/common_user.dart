class CommonUser {
  final String id;
  final String name;
  final String accessId;

  CommonUser({required this.name, required this.accessId, required this.id});

  static fromMap(Map<String, dynamic> map) {
    return CommonUser(
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
