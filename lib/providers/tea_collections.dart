import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teatracker/helpers/db_helper.dart';
import 'package:teatracker/models/lot.dart';
import 'package:teatracker/models/user.dart';
import '../models/supplier.dart';
import 'package:date_format/date_format.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

//  List<User> _currUser = [];
//
//  List<User> get currUser => _currUser;
  var _currUser = User();

  User get currUser => _currUser;
  int lotTotDeduct;

  Supplier _newSupplier;

  Supplier get newSupplier => _newSupplier;

  Future<void> userLogin(String id, String pwd) async {
    try {
      final userFromDb = await DBHelper.getLoginUserData(id, pwd);
      print(userFromDb.toString());
      if (userFromDb.isNotEmpty) {
        print(userFromDb[0]);

        _currUser.user_id = userFromDb[0]['user_Id'] as String;
        _currUser.password = userFromDb[0]['password'] as String;
      } else {
        print('user is no valid');
        throw Exception;
      }
    } catch (error) {
      print(error);
    }
    print(currUser.user_id);
    print(currUser.password);
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
      'supplier_id': _newSupplier.supplierId,
      'supplier_name': _newSupplier.supplierName,
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

  int calDeduct(int water, int cleaf, int other, int gweight) {
    // calculated deductions lot wise
    int deductPercnt = water + cleaf + other;
    double deductDouble = ((gweight * deductPercnt) / 100);
    lotTotDeduct = deductDouble.toInt();
    return deductDouble.toInt();
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

    notifyListeners();
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    print(now);
    return now;
  }
}
