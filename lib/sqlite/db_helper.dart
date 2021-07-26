import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolistflutter/models/task.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String CHECKED = 'checked';
  static const String TABLE = 'Tasks';
  static const String DB_NAME = 'tasks.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT,$NAME	TEXT NOT NULL,$CHECKED	INTEGER NOT NULL)");
  }

  Future<void> addTask(Task task) async {
    try {
      var dbClient = await db;
      await dbClient.insert(TABLE, task.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Task>> getTasks() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME, CHECKED]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Task> tasks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tasks.add(Task.fromMap(maps[i]));
      }
    }
    return tasks;
  }

  Future<void> delete(int id) async {
    var dbClient = await db;
    await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<void> update(Task task) async {
    var dbClient = await db;
    await dbClient
        .update(TABLE, task.toMap(), where: '$ID = ?', whereArgs: [task.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
