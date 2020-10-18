import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'teaLots.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE lots(lotId TEXT PRIMARY KEY, supplier_id TEXT ,container_type TEXT, no_of_containers INTEGER,leaf_grade TEXT, g_weight INTEGER, water INTEGER, course_leaf INTEGER, other INTEGER)');
    },
        version:
            1); // opendb method do create db name as teaLot.db and create table lots if not exists.
    //leaf_grade TEXT,gross_weight INTEGER,water INTEGER,course_leaf INTEGER,other INTEGER
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteLot(String table, String id) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'lotId = ?', whereArgs: [id]);
  }
}
