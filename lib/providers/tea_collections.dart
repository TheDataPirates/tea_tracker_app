import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:teatracker/helpers/db_helper.dart';
import 'package:teatracker/models/lot.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  void addLot(String supNo, String contType, int noOfCont, int gWeight,
      String lGrade, int water, int cLeaf, int other) {
    //create lot object
    final newLot = Lot(
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
      'supplier_id': newLot.supplier_id,
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
}
