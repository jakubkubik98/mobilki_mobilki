class Task {
  int? id;
  String name;
  String description;
  String creationDate;
  bool isDone;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.isDone,
  });
}
