import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDBManager extends GetxService implements AbsLocalDBManager {
  String dbName = 'autotager.db';
  late Database db;

  @override
  void onInit() {
    initDB();
    super.onInit();
  }

  @override
  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: 1,
    );
  }

  // String [tableScheme] example : "(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)"
  @override
  Future<void> createTable(String tableName, String tableScheme) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $tableName $tableScheme',
    );
  }

  @override
  Future<bool> deleteObject(String tableName, int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return true;
  }

  @override
  Future<void> insertObject(String tableName, Map<String, dynamic> data) async {
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> listObjects(String tableName) async {
    return await db.query(tableName);
  }

  @override
  Future<bool> objectExists(String tableName, int id) async {
    var result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> updateObject(String tableName, Map<String, dynamic> data) async {
    await db.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }
}

abstract class AbsLocalDBManager {
  Future<void> initDB();

  Future<void> createTable(String tableName, String tableScheme);

  Future<void> insertObject(String tableName, Map<String, dynamic> data);

  Future<void> updateObject(String tableName, Map<String, dynamic> data);

  Future<bool> deleteObject(String tableName, int id);

  Future<List<Object>> listObjects(String tableName);

  Future<bool> objectExists(String tableName, int id);
}
