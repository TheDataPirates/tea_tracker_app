import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'teaLots.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE lots(lotId TEXT PRIMARY KEY, supplier_id TEXT,supplier_name TEXT ,container_type TEXT, no_of_containers INTEGER,leaf_grade TEXT, g_weight INTEGER, water INTEGER, course_leaf INTEGER, other INTEGER,deductions INTEGER,net_weight INTEGER,date TEXT,is_deleted INTEGER,container1 INTEGER,container2 INTEGER,container3 INTEGER,container4 INTEGER,container5 INTEGER)');
    },
        version:
            1); // opendb method do create db name as teaLot.db and create table lots if not exists.
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(
      int isDeleted, String date) async {
    final db = await DBHelper.database();
    return await db.rawQuery(
        'SELECT * FROM lots WHERE is_deleted=?  AND date=?',
        ['$isDeleted', date]);
  }

  static Future<List<Map<String, dynamic>>> getDataWhereConditions(
      int isDeleted, String id, String date) async {
    final db = await DBHelper.database();
    return await db.rawQuery(
        'SELECT * FROM lots WHERE is_deleted=? AND supplier_id=? AND date=?',
        ['$isDeleted', id, date]);
  }

//  static Future<void> deleteLot(String table, String id) async {
//    final db = await DBHelper.database();
//    await db.delete(table, where: 'lotId = ?', whereArgs: [id]);
//  }

  static Future<void> deleteLot(int value, String id) async {
    final db = await DBHelper.database();
    int count = await db.rawUpdate(
        'UPDATE lots SET is_deleted = ?  WHERE lotId = ?', ['$value', '$id']);

    print('updated: $count');
  }
}
