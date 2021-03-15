class Task {
  final int id;
  final String description;
  final String done;

  Task(
    this.id,
    this.description,
    this.done,
  );

  @override
  String toString() {
    return 'Task{id: $id, description: $description, done: $done}';
  }
}
