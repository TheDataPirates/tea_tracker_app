import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';

import '../constants.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  //media query width for row
  final double width = 0.15;
  final double deduct_width = 0.2;

  static final _supplierController = TextEditingController();
  static final _containerTypeController = TextEditingController();
  static final _containerNoController = TextEditingController();
  static final _grossWeightController = TextEditingController();
  static final _leafGradeController = TextEditingController();
  static final _boxNoController = TextEditingController();

  final _waterLevelController = TextEditingController();
  final _courseLeafController = TextEditingController();
  final _otherDeductController = TextEditingController();

  final supplier_no = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'Supplier no',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _supplierController,
    style: TextStyle(fontSize: 40),
  );
  final container_type = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'Container type',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _containerTypeController,
    style: TextStyle(fontSize: 40),
  );
  final no_of_container = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'No of container',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _containerNoController,
    style: TextStyle(fontSize: 40),
  );
  final gross_weight = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'Gross weight',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _grossWeightController,
    style: TextStyle(fontSize: 40),
  );
  final leaf_grade = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'Leaf grade',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _leafGradeController,
    style: TextStyle(fontSize: 40),
  );
  final box_no = TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
      filled: true,
      fillColor: Colors.lightGreen,
      labelText: 'Box no',
      labelStyle: kTextFieldLabelStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
        borderSide: BorderSide.none,
      ),
    ),
    controller: _boxNoController,
    style: TextStyle(fontSize: 40),
  );

  void saveLot() {
    if (_supplierController.text.isEmpty) {
      return;
    }
    Provider.of<TeaCollections>(context, listen: false).addLot(
        _supplierController.text,
        _containerTypeController.text,
        int.parse(_containerNoController.text),
        double.parse(_grossWeightController.text),
        _leafGradeController.text,
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
                              child: supplier_no),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: container_type),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: no_of_container),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: gross_weight),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: leaf_grade),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * width,
                              child: box_no),
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
