class ToDo {
  late int id;
  late String name;
  late String description;
  late int createdAt;
  late bool isDone;

  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['desc'];
    createdAt = map['createdAt'];
    isDone = map['isDone'] == 1;
  }
}
