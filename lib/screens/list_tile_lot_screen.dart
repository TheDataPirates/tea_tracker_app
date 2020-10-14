import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';

import '../constants.dart';

class ListTileLot extends StatelessWidget {
  final String supplier_id;
//  final String container_type;
//  final int no_of_containers;
//  final double gross_weight;
//  final String leaf_grade;
//  final double water;
//  final double course_leaf;
//  final double other;

  ListTileLot({
    this.supplier_id,
//      this.container_type,
//      this.no_of_containers,
//      this.gross_weight,
//      this.leaf_grade,
//      this.water,
//      this.course_leaf,
//      this.other
  });

  @override
  Widget build(BuildContext context) {
    final selectedLot = Provider.of<TeaCollections>(context)
        .lot_items
        .firstWhere((supp) =>
            supp.supplier_id ==
            supplier_id); // provider will check selected supp id and give its lots object data along to class
    return Scaffold(
      appBar: AppBar(
        title: Text("LOT details"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Supplier :", style: kTextLotlistStyle),
                  Text(selectedLot.supplier_id, style: kTextLotlistStyle),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Container type :", style: kTextLotlistStyle),
                  Text(selectedLot.container_type, style: kTextLotlistStyle),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number of containers :", style: kTextLotlistStyle),
                  Text("${selectedLot.no_of_containers}",
                      style: kTextLotlistStyle),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gross weight :", style: kTextLotlistStyle),
                  Text(selectedLot.gross_weight.toString(),
                      style: kTextLotlistStyle),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Leaf grade :", style: kTextLotlistStyle),
                  Text(selectedLot.leaf_grade, style: kTextLotlistStyle)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Water % :", style: kTextLotlistStyle),
                  Text(selectedLot.water.toString(), style: kTextLotlistStyle)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Course leaf % :", style: kTextLotlistStyle),
                  Text(selectedLot.course_leaf.toString(),
                      style: kTextLotlistStyle)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Other % :", style: kTextLotlistStyle),
                  Text(selectedLot.other.toString(), style: kTextLotlistStyle)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
