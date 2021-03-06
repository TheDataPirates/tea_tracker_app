import 'dart:convert';

import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:teatracker/constants.dart';

class DBHelper {
  static List _users = [];
  static String hash;

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'teaLots.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE lots(lotId TEXT PRIMARY KEY, user_Id TEXT, supplier_id TEXT,supplier_name TEXT ,container_type TEXT, no_of_containers INTEGER,leaf_grade TEXT, g_weight INTEGER, water INTEGER, course_leaf INTEGER, other INTEGER,deductions INTEGER,net_weight INTEGER,date TEXT,is_deleted INTEGER,container1 INTEGER,container2 INTEGER,container3 INTEGER,container4 INTEGER,container5 INTEGER,bulkId INTEGER,method String)');
      await db.execute(
          'CREATE TABLE users(user_Id TEXT PRIMARY KEY, password TEXT, name TEXT)');
      await db.execute(
          'CREATE TABLE suppliers(supplier_id TEXT PRIMARY KEY, name TEXT)');
    },
        version:
            1); // open db method do create db name as teaLot.db and create table lots if not exists.
  }

  static Future<List<Map<String, dynamic>>> getLoginUserData(
      String id, String password) async {
    // var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 08);

    // print('hashed pw');
    // print(hash);
    final db = await DBHelper.database();
    final url = '$kUrl/auth/users';
    final url2 = '$kUrl/supp/suppliers';

    try {
      final dataListUsers = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final extractedDataList = jsonDecode(dataListUsers.body);
       print(extractedDataList);
      List loadedUsers = extractedDataList['users'];

      final dataListSuppliers = await http.get(
        url2,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final extractedDataList2 = jsonDecode(dataListSuppliers.body);
//      print(extractedDataList2);
      List loadedSuppliers = extractedDataList2['suppliers'];

      await db.transaction((txn) async {
        //insert hard coded user details
        for (var i in loadedUsers) {
          // print(i);
          var pw = i['password'];
          var name = i['name'];
          await txn.rawInsert(
              "INSERT INTO users(user_Id, password, name) VALUES(${i['user_id']}, '$pw', '$name')");
        }
        for (var i in loadedSuppliers) {
          // print(i['supplier_id']);
          // print(i['name']);

          var name = i['name'];
          await txn.rawInsert(
              "INSERT INTO suppliers(supplier_id, name) VALUES(${i['supplier_id']}, '$name')");
        }
      });
    } catch (error) {
      print(
          'users and suppliers are already saved'); //this will throw exception . so to avoid it used print func.
    }
    hash = await FlutterBcrypt.hashPw(
        password: '$password', salt: r'$2a$08$bjJcpjHjmRMcsbGlsfXUpO');
    return await db.rawQuery(
        'SELECT * FROM users WHERE user_Id=? AND password=?',
        [id, hash]); //see whether user available.
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> selectSupByID(String supId) async {
    final db = await DBHelper.database();
    // db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return await db
        .rawQuery('SELECT * FROM suppliers WHERE supplier_id=? ', [supId]);
  }

  static Future<List<Map<String, dynamic>>> selectSupByName(
      String supName) async {
    final db = await DBHelper.database();
    // db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return await db
        .rawQuery('SELECT * FROM suppliers WHERE name=? ', [supName]);
  }

  static Future<void> delete() async {
    final db = await DBHelper.database();
    await db.rawQuery('DELETE FROM lots');
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

  static Future<List<Map<String, dynamic>>> getDataForSync(String date) async {
    final db = await DBHelper.database();
    return await db.rawQuery('SELECT * FROM lots WHERE date=?', [date]);
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
