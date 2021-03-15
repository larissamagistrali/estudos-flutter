import 'package:flutter_tasks/models/task.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TaskDao {
  static const String _tableName = 'tasks';
  static const String _id = 'id';
  static const String _description = 'description';
  static const String _done = 'done';

  static const String tableSql = 'CREATE TABLE $_tableName( '
      '$_id INTEGER PRIMARY KEY, '
      '$_description TEXT, '
      '$_done TEXT)';

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_description] = task.description;
    taskMap[_done] = task.done;
    return taskMap;
  }

  Future<List<Task>> findAllPendent() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT * FROM tasks WHERE done = 'N'");
    final List<Task> tasks = _toList(result);
    return tasks;
  }

  Future<List<Task>> findAllDone() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT * FROM tasks WHERE done = 'Y'");
    final List<Task> tasks = _toList(result);
    return tasks;
  }

  Future<int> updateToDone(int id) async {
    final Database db = await getDatabase();
    return db.rawUpdate("UPDATE tasks SET done = 'Y' WHERE id = ?", [id]);
  }

  Future<int> save(Task task) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> taskMap = _toMap(task);
    return db.insert(_tableName, taskMap);
  }

  List<Task> _toList(List<Map<String, dynamic>> result) {
    final List<Task> tasks = [];
    for (final Map<String, dynamic> row in result) {
      final id = int.tryParse(row[_id].toString());
      final description = row[_description].toString();
      final done = row[_done].toString();

      final Task task = Task(
        id,
        description,
        done,
      );
      tasks.add(task);
    }
    return tasks;
  }
}
