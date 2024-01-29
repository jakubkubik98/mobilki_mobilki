class ToDo {
  int? id;
  late String name;
  late String description;
  late int createdAt;
  late int isDone; // Make it non-nullable and default to 0

  ToDo({
    required this.name,
    required this.description,
    int? createdAt, // time since Epoch (1 Jan 1970) in milliseconds
    int? isDone, // default to null
  })  : createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        this.isDone = isDone ?? 0;

  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['desc'];
    createdAt = map['createdAt'];
    isDone = map['isDone'] ?? 0; // Default to 0 if not present

    // Handle the case when id is null in the map
    id ??= 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'desc': description,
    };

    // Include the ID, createdAt, and isDone only if they are not null or the default value
    if (id != null) {
      map['id'] = id;
    }
    if (createdAt != null) {
      map['createdAt'] = createdAt;
    }
    if (isDone != null) {
      map['isDone'] = isDone; // Use 1 for true and 0 for false
    }

    return map;
  }
}
