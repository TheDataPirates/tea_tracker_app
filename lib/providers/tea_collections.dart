import 'package:flutter/foundation.dart';
import 'package:teatracker/models/lot.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  void addLot(String supNo, String contType, int noOfCont, double gWeight,
      String lGrade, double water, double cLeaf, double other) {
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
  }
}
