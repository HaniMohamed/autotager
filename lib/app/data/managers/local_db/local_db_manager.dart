import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDBManager implements AbsLocalDBManager {
  String dbName = 'autotager.db';
  late Database db;

  @override
  Future<void> initDB() async {
    db = await openDatabase(
      await getDatabasesPath() + dbName,
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
  Future<bool> deleteObject(String tableName, String key, dynamic value) async {
    await db.delete(
      tableName,
      where: '$key = ?',
      whereArgs: [value],
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
  Future<List<Map<String, dynamic>>> listObjects(String tableName,
      {String? orderByKey}) async {
    return await db.query(tableName,
        orderBy: orderByKey != null ? '$orderByKey DESC' : null);
  }

  @override
  Future<bool> objectExists(String tableName, String key, dynamic value) async {
    var result = await db.query(
      tableName,
      where: '$key = ?',
      whereArgs: [value],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> updateObject(String tableName, Map<String, dynamic> data,
      String key, dynamic value) async {
    await db.update(
      tableName,
      data,
      where: '$key = ?',
      whereArgs: [value],
    );
  }

  @override
  Future<void> clearTable(String tableName) async {
    await db.execute("DELETE FROM $tableName");
  }

  @override
  Future<Map<String, dynamic>?> fetchObject(
      String tableName, String key, value) async {
    var result = await db.query(
      tableName,
      where: '$key = ?',
      whereArgs: [value],
    );
    return result.isNotEmpty ? result.first : null;
  }
}

abstract class AbsLocalDBManager {
  Future<void> initDB();

  Future<void> createTable(String tableName, String tableScheme);

  Future<void> insertObject(String tableName, Map<String, dynamic> data);

  Future<void> updateObject(
      String tableName, Map<String, dynamic> data, String key, dynamic value);

  Future<bool> deleteObject(String tableName, String key, dynamic value);

  Future<void> clearTable(String tableName);

  Future<List<Map<String, dynamic>>> listObjects(String tableName,
      {String? orderByKey});

  Future<Map<String, dynamic>?> fetchObject(
      String tableName, String key, dynamic value);

  Future<bool> objectExists(String tableName, String key, dynamic value);
}
