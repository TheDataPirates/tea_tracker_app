import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teatracker/helpers/db_helper.dart';
import 'package:teatracker/models/bulk.dart';
import 'package:teatracker/models/lot.dart';
import 'package:teatracker/models/user.dart';
import '../constants.dart';
import '../models/supplier.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  var _currUser = User();

  User get currUser => _currUser;
  int lotTotDeduct;

  Supplier _newSupplier;

  Supplier get newSupplier => _newSupplier;

  Bulk _newBulk;

  Bulk get newBulk => _newBulk;

  Future<bool> userLogin(String id, String pwd) async {
    try {
      final userFromDb = await DBHelper.getLoginUserData(id, pwd);
      if (userFromDb.isNotEmpty) {
        print(userFromDb[0]);

        _currUser.user_id = userFromDb[0]['user_Id'] as String;
        _currUser.password = userFromDb[0]['password'] as String;
        return true;
      } else {
        print('user is no valid');
        return false;
      }
    } catch (error) {
      print(error);
    }
    // print(currUser.user_id);
    // print(currUser.password);
  }

  Future<void> addLot(
      String Id,
      String supNo,
      String supName,
      String contType,
      int noOfCont,
      int gWeight,
      String lGrade,
      int water,
      int cLeaf,
      int other,
      int deducts,
      int nWeight,
      String date,
      int cont1,
      int cont2,
      int cont3,
      int cont4,
      int cont5) async {
    //create lot object
    final newLot = Lot(
        lotId: Id,
        user_Id: currUser.user_id,
        supplier_id: supNo,
        supplier_name: supName,
        container_type: contType,
        no_of_containers: noOfCont,
        gross_weight: gWeight,
        leaf_grade: lGrade,
        water: water,
        course_leaf: cLeaf,
        other: other,
        deductions: deducts,
        net_weight: nWeight,
        date: date,
        container1: cont1,
        container2: cont2,
        container3: cont3,
        container4: cont4,
        container5: cont5);

    _lot_items.add(newLot); // add new obj to items array

    notifyListeners();
    await DBHelper.insert('lots', {
      'lotId': newLot.lotId,
      'user_Id': currUser.user_id,
      'supplier_id': newSupplier.supplierId,
      'supplier_name': newSupplier.supplierName,
      'container_type': newLot.container_type,
      'no_of_containers': newLot.no_of_containers,
      'leaf_grade': newLot.leaf_grade,
      'g_weight': newLot.gross_weight,
      'water': newLot.water,
      'course_leaf': newLot.course_leaf,
      'other': newLot.other,
      'deductions': newLot.deductions,
      'net_weight': newLot.net_weight,
      'date': newLot.date,
      'is_deleted': newLot.isDeleted,
      'container1': newLot.container1,
      'container2': newLot.container2,
      'container3': newLot.container3,
      'container4': newLot.container4,
      'container5': newLot.container5,
      'bulkId': newBulk.bulkId,
      'method': newBulk.method
    });
  }

//getting all records
  Future<void> fetchAndSetLotData(String date) async {
    final dataList = await DBHelper.getData(0, date);
    _lot_items = [];
    _lot_items = dataList
        .map(
          (item) => Lot(
            lotId: item['lotId'],
            user_Id: item['user_Id'],
            supplier_id: item['supplier_id'],
            supplier_name: item['supplier_name'],
            container_type: item['container_type'],
            no_of_containers: item['no_of_containers'],
            leaf_grade: item['leaf_grade'],
            gross_weight: item['g_weight'],
            water: item['water'],
            course_leaf: item['course_leaf'],
            other: item['other'],
            deductions: item['deductions'],
            net_weight: item['net_weight'],
            date: item['date'],
            isDeleted: item['is_deleted'],
            container1: item['container1'],
            container2: item['container2'],
            container3: item['container3'],
            container4: item['container4'],
            container5: item['container5'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetLotDataWhereIsDeleted(String id, String date) async {
    final dataList = await DBHelper.getDataWhereConditions(
        0, id, date); //raw query to get isdeleted = 0
    _lot_items = [];
    _lot_items = dataList
        .map(
          (item) => Lot(
            lotId: item['lotId'],
            user_Id: item['user_Id'],
            supplier_id: item['supplier_id'],
            supplier_name: item['supplier_name'],
            container_type: item['container_type'],
            no_of_containers: item['no_of_containers'],
            leaf_grade: item['leaf_grade'],
            gross_weight: item['g_weight'],
            water: item['water'],
            course_leaf: item['course_leaf'],
            other: item['other'],
            deductions: item['deductions'],
            net_weight: item['net_weight'],
            date: item['date'],
            isDeleted: item['is_deleted'],
            container1: item['container1'],
            container2: item['container2'],
            container3: item['container3'],
            container4: item['container4'],
            container5: item['container5'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void deleteLot(String id) {
    _lot_items
        .removeWhere((lot) => lot.lotId == id); // remove lot from the array
    DBHelper.deleteLot(1, id); // setting isDeleted = 1 in sqldb
    notifyListeners();
  }

  Future<void> syncLocalDb(String date) async {
    _lot_items = [];
    final dataList = await DBHelper.getDataForSync(date);
    _lot_items = dataList
        .map(
          (item) => Lot(
            lotId: item['lotId'],
            user_Id: item['user_Id'],
            supplier_id: item['supplier_id'],
            supplier_name: item['supplier_name'],
            container_type: item['container_type'],
            no_of_containers: item['no_of_containers'],
            leaf_grade: item['leaf_grade'],
            gross_weight: item['g_weight'],
            water: item['water'],
            course_leaf: item['course_leaf'],
            other: item['other'],
            deductions: item['deductions'],
            net_weight: item['net_weight'],
            date: item['date'],
            isDeleted: item['is_deleted'],
            container1: item['container1'],
            container2: item['container2'],
            container3: item['container3'],
            container4: item['container4'],
            container5: item['container5'],
            bulkId: item['bulkId'],
            method: item['method'],
          ),
        )
        .toList();
    const url = '$kUrl/bleaf/sync';

    for (var i in _lot_items) {
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'lotId': i.lotId,
            'no_of_containers': i.no_of_containers,
            'grade_GL': i.leaf_grade,
            'g_weight': i.gross_weight,
            'water': i.water,
            'course_leaf': i.course_leaf,
            'other': i.other,
            'bulkId': i.bulkId,
            'method': i.method,
            'suppId': i.supplier_id,
            'deduction': i.deductions,
            'net_weight': i.net_weight,
            'user_Id': i.user_Id,
            'container1': i.container1,
            'container2': i.container2,
            'container3': i.container3,
            'container4': i.container4,
            'container5': i.container5,
            'date': i.date,
            'container_type': i.container_type
          }),
        );
        if (response.statusCode != 200) {
          // print(lot_items.length);
          // await DBHelper.delete();
          // return;
          throw Exception('Failed ');
        }
      } catch (error) {
        throw error;
      }
    }
    await DBHelper.delete();
  }

  int calDeduct(int water, int cleaf, int other, int gweight, String contType,
      int noOfCont) {
    // calculated deductions lot wise
    double contDeducts;
    int deductPercnt = water + cleaf + other;
    switch (contType) {
      case 'A':
        {
          contDeducts = 0.5 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.5 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'B':
        {
          contDeducts = 0.75 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.75 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'C':
        {
          contDeducts = 1.0 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (1.0 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'D':
        {
          contDeducts = 1.25 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (1.25 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'E':
        {
          contDeducts = 0.0 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.0 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
    }
  }

  int calNetWeight(int gWeight) {
    // calculate net weight lot wise
    return (gWeight - lotTotDeduct);
  }

  int totalDeducts() {
    // use in print screen
    try {
      int total = 0;
      lot_items.forEach((item) => total += item.deductions);
      print(total);
      return total;
    } catch (e) {
      print(e);
    }
  }

  void saveSupplier(String supId, String supName) {
    _newSupplier = Supplier(supId, supName);

    _newBulk = Bulk(Random().nextInt(100000000), "AgentOriginal");
    notifyListeners();
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    print(now);
    return now;
  }
}
