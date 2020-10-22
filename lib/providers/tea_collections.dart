import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:teatracker/helpers/db_helper.dart';
import 'package:teatracker/models/lot.dart';
import '../models/supplier.dart';
import 'package:date_format/date_format.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  int lotTotDeduct;

  Supplier _newSupplier;
//  = Supplier("unknown",
//      "unknown"); //set default value otherwise throws exception cant find supplierID

  Supplier get newSupplier => _newSupplier;

  void addLot(
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
      String date) {
    //create lot object
    final newLot = Lot(
      lotId: Id,
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
    );

    _lot_items.add(newLot); // add new obj to items array

    notifyListeners();
    DBHelper.insert('lots', {
      'lotId': newLot.lotId,
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
      'is_deleted': newLot.isDeleted
    });
  }
//getting all records
//  Future<void> fetchAndSetLotData() async {
//    final dataList = await DBHelper.getData('lots');
//
//    _lot_items = dataList
//        .map(
//          (item) => Lot(
//            lotId: item['lotId'],
//            supplier_id: item['supplier_id'],
//            supplier_name: item['supplier_name'],
//            container_type: item['container_type'],
//            no_of_containers: item['no_of_containers'],
//            leaf_grade: item['leaf_grade'],
//            gross_weight: item['g_weight'],
//            water: item['water'],
//            course_leaf: item['course_leaf'],
//            other: item['other'],
//            date: item['date'],
//          ),
//        )
//        .toList();
//    notifyListeners();
//  }

  Future<void> fetchAndSetLotDataWhereIsDeleted(String id, String date) async {
    final dataList = await DBHelper.getDataWhereConditions(
        0, id, date); //raw query to get isdeleted = 0

    _lot_items = dataList
        .map(
          (item) => Lot(
            lotId: item['lotId'],
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
