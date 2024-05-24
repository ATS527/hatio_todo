class Project {
  final String id;
  final String title;
  final List<String> todoIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.title,
    required this.todoIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json["project"]['id'],
      title: json["project"]['title'],
      todoIds: List<String>.from(json["project"]['todoIds']),
      createdAt: DateTime.parse(json["project"]['createdAt']),
      updatedAt: DateTime.parse(json["project"]['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'todoIds': todoIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  //from map<string,dynamic> to list
  static List<Project> fromJsontoList(Map<String, dynamic> map) {
    List<Project> list = [];
    map.forEach((key, value) {
      list.add(Project.fromJson(value));
    });
    return list;
  }
}
