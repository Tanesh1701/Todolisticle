import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/model/model.dart';

class DatabaseProvider {
  static const String TABLE_TASKS = 'task';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_TEXT = 'text';

  DatabaseProvider._(); 
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'TaskDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute("CREATE TABLE $TABLE_TASKS($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_TEXT TEXT)");
      }
    );
  }
  Future<List<Task>> getTasks() async {
    final db = await database;
    var tasks = await db.query(
      TABLE_TASKS,
      columns: [COLUMN_ID, COLUMN_TEXT]
    );

    List<Task> taskList = List<Task>();

    tasks.forEach((currentTask) {
      Task task = Task.fromMap(currentTask);
      taskList.add(task);
    });
    return taskList;
  }

  Future<Task> insert(Task task) async {
    final db = await database;
    task.id = await db.insert(TABLE_TASKS, task.toMap());
    return task;
  }

  Future<int>delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_TASKS,
      where: "id=?",
      whereArgs: [id]
    );
  }
}

