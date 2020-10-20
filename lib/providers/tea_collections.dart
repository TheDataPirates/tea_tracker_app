import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:teatracker/helpers/db_helper.dart';
import 'package:teatracker/models/lot.dart';
import '../models/supplier.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  Supplier _newSupplier = Supplier("unknown",
      "unknown"); //set default value otherwise throws exception cant find supplierID

  Supplier get newSupplier => _newSupplier;

  void addLot(String Id, String supNo, String contType, int noOfCont,
      int gWeight, String lGrade, int water, int cLeaf, int other) {
    //create lot object
    final newLot = Lot(
        lotId: Id,
        supplier_id: supNo,
        container_type: contType,
        no_of_containers: noOfCont,
        gross_weight: gWeight,
        leaf_grade: lGrade,
        water: water,
        course_leaf: cLeaf,
        other: other);

    _lot_items.add(newLot); // add new obj to items array

    notifyListeners();
    DBHelper.insert('lots', {
      'lotId': newLot.lotId,
      'supplier_id': _newSupplier.supplierId,
      'container_type': newLot.container_type,
      'no_of_containers': newLot.no_of_containers,
      'leaf_grade': newLot.leaf_grade,
      'g_weight': newLot.gross_weight,
      'water': newLot.water,
      'course_leaf': newLot.course_leaf,
      'other': newLot.other
    });
  }

  Future<void> fetchAndSetLotData() async {
    final dataList = await DBHelper.getData('lots');

    _lot_items = dataList
        .map(
          (item) => Lot(
              lotId: item['lotId'],
              supplier_id: item['supplier_id'],
              container_type: item['container_type'],
              no_of_containers: item['no_of_containers'],
              leaf_grade: item['leaf_grade'],
              gross_weight: item['g_weight'],
              water: item['water'],
              course_leaf: item['course_leaf'],
              other: item['other']),
        )
        .toList();
    notifyListeners();
  }

  void deleteLot(String id) {
    _lot_items.removeWhere((lot) => lot.lotId == id);
    DBHelper.deleteLot('lots', id); // deleting lot permanently
    notifyListeners();
  }

  void saveSupplier(String supId, String supName) {
    _newSupplier = Supplier(supId, supName);

    notifyListeners();
  }
}
