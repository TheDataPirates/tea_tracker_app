import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/widgets/tea_acquiring_input.dart';

import '../constants.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  //media query width for row
  final double width = 0.15;
  final double deduct_width = 0.2;

  final _waterLevelController = TextEditingController();
  final _courseLeafController = TextEditingController();
  final _otherDeductController = TextEditingController();

  Future<void> saveLot() async {
    if (TeaAcquiringInput.supplierController.text.isEmpty) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('No supplier name entered'),
                  Text('Please Enter again'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    Provider.of<TeaCollections>(context, listen: false).addLot(
        TeaAcquiringInput.supplierController.text,
        TeaAcquiringInput.containerTypeController.text,
        int.parse(TeaAcquiringInput.containerNoController.text),
        double.parse(TeaAcquiringInput.grossWeightController.text),
        TeaAcquiringInput.leafGradeController.text,
        double.parse(_waterLevelController.text),
        double.parse(_courseLeafController.text),
        double.parse(_otherDeductController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
//                      color: Colors.amber,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: TeaAcquiringInput.supplier_no),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: TeaAcquiringInput.container_type),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: TeaAcquiringInput.no_of_container),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: TeaAcquiringInput.gross_weight),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: TeaAcquiringInput.leaf_grade),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        'DEDUCTIONS',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 10,
                        ),
                      ),
                    ),
                    Container(
//                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  deduct_width,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.lightGreen,
                                  labelText: 'Water',
                                  labelStyle: kTextFieldLabelStyle,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(13.0),
                                    ),
                                  ),
                                ),
                                controller: _waterLevelController,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  deduct_width,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.lightGreen,
                                  labelText: 'Course Leaf',
                                  labelStyle: kTextFieldLabelStyle,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(13.0),
                                    ),
                                  ),
                                ),
                                controller: _courseLeafController,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  deduct_width,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.lightGreen,
                                  labelText: 'Others',
                                  labelStyle: kTextFieldLabelStyle,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(13.0),
                                    ),
                                  ),
                                ),
                                controller: _otherDeductController,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton.icon(
              onPressed: saveLot,
              icon: Icon(Icons.add),
              label: Text(
                'SAVE',
                style: TextStyle(fontSize: 20),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
