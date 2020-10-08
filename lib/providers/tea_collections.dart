import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:teatracker/models/lot.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  static LocalStorage storage = new LocalStorage('lot');

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
    saveLocalLot(newLot);
    getLotFromCache(newLot);
    notifyListeners();
  }

  void saveLocalLot(Lot newlot) async {
    await storage.ready;
    storage.setItem("${newlot.supplier_id}", newlot);
  }

  Future<void> getLotFromCache(Lot newlot) async {
    await storage.ready;
    Map<String, dynamic> data = storage.getItem('${newlot.supplier_id}');
    if (data == null) {
      return null;
    }
    print(data['supplier_id']);
  }
}
