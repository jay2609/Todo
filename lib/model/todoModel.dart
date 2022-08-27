class todoModel {
  String id, title, description;
  bool completed;
  DateTime createdDate;
  todoModel({
    required this.createdDate,
    required this.title,
    required this.id,
    required this.description,
    required this.completed,
  });

  todoModel.fromMap(Map<String, dynamic>? map, this.id)
      : title = map!['title'] ?? '',
        description = map["description"] ?? '',
        completed = map['completed'] ?? false,
        createdDate = map["createdDate"].toDate() ?? DateTime.now();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map["id"] = id;
    map['createdDate'] = createdDate;
    map['completed'] = completed;
    return map;
  }
}
