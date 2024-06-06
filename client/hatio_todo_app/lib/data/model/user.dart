import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<String> projectIds;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.projectIds,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, email, password, projectIds, createdAt];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["user"]['id'],
      name: json["user"]['name'],
      email: json["user"]['email'],
      password: json["user"]['password'],
      projectIds: List<String>.from(json["user"]['project_ids'] ?? []),
      createdAt: DateTime.parse(json["user"]['createdAt']),
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
