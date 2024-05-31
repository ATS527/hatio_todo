class Project {
  final String id;
  final String title;
  final List<String>? todoIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Project({
    required this.id,
    required this.title,
    this.todoIds,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    // final todoList = json["project"]["todos"];
    return Project(
      id: json['id'],
      title: json['title'],
      todoIds: json['todoIds'] != null
          ? List<String>.from(json['todoIds'])
          : <String>[],
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
      'todoIds': todoIds,
      'createdAt': createdAt?.toIso8601String() ?? "",
      'updatedAt': updatedAt?.toIso8601String() ?? "",
    };
  }

  //from map<string,dynamic> to list
  static List<Project> fromJsontoList(List<dynamic> json) {
    List<Project> list = [];

    if (json.isNotEmpty) {
      for (var item in json) {
        list.add(Project.fromJson(item));
      }
    } else {
      return list;
    }

    return list;
  }
}
