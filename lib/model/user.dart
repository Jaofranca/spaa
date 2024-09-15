class User {
  final String name;
  final String accessId;
  final String identification;

  User(
      {required this.name,
      required this.accessId,
      required this.identification});

  static fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      accessId: map['accessId'] as String,
      identification: map['identification'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accessId': accessId,
      'identification': identification
    };
  }
}
