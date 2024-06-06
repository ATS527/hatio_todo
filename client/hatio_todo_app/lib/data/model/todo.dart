import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Todo({
    required this.id,
    required this.title,
    this.status = false,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props =>
      [id, title, status, createdAt ?? "", updatedAt ?? ""];

  factory Todo.fromJson(Map<String, dynamic> json) {
    print(json);
    return Todo(
      id: json['id'],
      title: json['description'],
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }

  static List<Todo> fromJsonToList(List<dynamic> map) {
    List<Todo> list = [];
    for (var item in map) {
      list.add(Todo.fromJson(item));
    }
    return list;
  }
}
