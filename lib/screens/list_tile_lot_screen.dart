import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import '../constants.dart';

class ListTileLot extends StatelessWidget {
  final String lot_id;

  ListTileLot({
    this.lot_id,
  });

  @override
  Widget build(BuildContext context) {
    final selectedLot = Provider.of<TeaCollections>(context)
        .lot_items
        .firstWhere((supp) =>
            supp.lotId ==
            lot_id); // provider will check selected supp id and give its lots object data along to class
    return Scaffold(
      appBar: AppBar(
        title: Text("LOT details"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Supplier :", style: kLotDetailTextStyle),
                    Text(selectedLot.supplier_id, style: kLotDetailTextStyle),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Container type :", style: kLotDetailTextStyle),
                    Text(selectedLot.container_type, style: kLotDetailTextStyle),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Number of containers :",
                        style: kLotDetailTextStyle),
                    Text("${selectedLot.no_of_containers}",
                        style: kLotDetailTextStyle),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Gross weight :", style: kLotDetailTextStyle),
                    Text(selectedLot.gross_weight.toString(),
                        style: kLotDetailTextStyle),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Leaf grade :", style: kLotDetailTextStyle),
                    Text(selectedLot.leaf_grade, style: kLotDetailTextStyle)
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Water % :", style: kLotDetailTextStyle),
                    Text(selectedLot.water.toString(), style: kLotDetailTextStyle)
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Course leaf % :", style: kLotDetailTextStyle),
                    Text(selectedLot.course_leaf.toString(),
                        style: kLotDetailTextStyle)
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Other % :", style: kLotDetailTextStyle),
                    Text(selectedLot.other.toString(), style: kLotDetailTextStyle)
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                color: kCardColor,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Container1 :", style: kLotDetailTextStyle),
                    Text(selectedLot.container1.toString(),
                        style: kLotDetailTextStyle),
                    const Text("Container2 :", style: kLotDetailTextStyle),
                    Text(selectedLot.container2.toString(),
                        style: kLotDetailTextStyle),
                    const Text("Container3 :", style: kLotDetailTextStyle),
                    Text(selectedLot.container3.toString(),
                        style: kLotDetailTextStyle),
                    const Text("Container4 :", style: kLotDetailTextStyle),
                    Text(selectedLot.container4.toString(),
                        style: kLotDetailTextStyle),
                    const Text("Container5 :", style: kLotDetailTextStyle),
                    Text(selectedLot.container5.toString(),
                        style: kLotDetailTextStyle)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
