class Todo {
  final String id;
  final String title;
  final bool status;

  Todo({
    required this.id,
    required this.title,
    this.status = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["todo"]['id'],
      title: json["todo"]['title'],
      status: json["todo"]['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }

  static List<Todo> fromJsonToList(Map<String, dynamic> map) {
    List<Todo> list = [];
    map.forEach((key, value) {
      list.add(Todo.fromJson(value));
    });
    return list;
  }
}
