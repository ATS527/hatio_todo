class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<String> projectIds;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.projectIds,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      projectIds: List<String>.from(json['projectIds']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'projectIds': projectIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
