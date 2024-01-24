class ToDo {

  ToDo({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.isDone,
  });
  final int id;
  final String name;
  final String description;
  final int createdAt;
  final bool isDone;
}
