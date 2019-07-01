import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  static final _objectTableName = "ObjectStore";

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 4, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE $_objectTableName(object_key TEXT PRIMARY KEY, object_value TEXT)");
    print("Created tables");
  }

  Future<int> save(object_key, object_value) async {
    var dbClient = await db;
    var found = await find(object_key);
    if (found != null) {
      await delete(object_key);
    }

    String safe_value =
        object_value.toString().replaceAll(new RegExp(r'"'), "'");
    int res = await dbClient.insert(_objectTableName,
        {"object_key": object_key.toString(), "object_value": safe_value});
    return res;
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    int res = await dbClient.delete(_objectTableName);
    return res;
  }

  Future<int> delete(object_key) async {
    var dbClient = await db;
    int res = await dbClient.delete(_objectTableName,
        where: "object_key = ?", whereArgs: [object_key.toString()]);
    return res;
  }

  Future<String> find(object_key) async {
    var dbClient = await db;
    List<Map<String, dynamic>> records = await dbClient.query(_objectTableName,
        where: "object_key = ?", whereArgs: [object_key.toString()]);
    try {
      String unsafe_value = records.first["object_value"]
          .toString()
          .replaceAll(new RegExp(r"'"), '"');
      if (unsafe_value == null) {
        return "";
      } else {
        return unsafe_value;
      }
    }
    catch (e) {
      return "";
    }
  }
}
