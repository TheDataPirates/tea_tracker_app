import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/models/lot.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/widgets/tea_acquiring_input.dart';
import 'package:intl/intl.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  var _editedLot = Lot(
      container_type: '',
      no_of_containers: 0,
      gross_weight: 0,
      leaf_grade: '',
      water: 0,
      course_leaf: 0,
      other: 0);

  final _containerNoController = TextEditingController();

  @override
  void dispose() {
    _containerNoController.dispose();

    super.dispose();
  }

  //media query width for row
  final double width = 0.2;
  final double deduct_width = 0.2;

  Future<void> saveLot() async {
    if (_fbkey.currentState.validate()) {
      _fbkey.currentState.save();
      print(_fbkey.currentState.value);

      final provider = Provider.of<TeaCollections>(context, listen: false);

      final currentSupplier = provider
          .newSupplier; // get supplier id which entered on sup input screen via provider
      Provider.of<TeaCollections>(context, listen: false).addLot(
        DateTime.now().toString(),
        //get now time as lot ID
        currentSupplier.supplierId,
        currentSupplier.supplierName,
        _editedLot.container_type,
        _editedLot.no_of_containers,
        _editedLot.gross_weight,
        _editedLot.leaf_grade,
        _editedLot.water,
        _editedLot.course_leaf,
        _editedLot.other,
        provider.calDeduct(
          _editedLot.water,
          _editedLot.course_leaf,
          _editedLot.other,
          _editedLot.gross_weight,
        ),
        provider.calNetWeight(
          _editedLot.gross_weight,
        ),
        provider.getCurrentDate(), //get current data & save
      );
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: FormBuilder(
        key: _fbkey,
        child: Column(
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
                        height: mediaQuery.height * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InputField(
                              labelText: 'Container Type',
                              width: width,
                              validator: [FormBuilderValidators.required()],
                              onSave: (value) {
                                _editedLot = Lot(
                                    container_type: value,
                                    no_of_containers:
                                        _editedLot.no_of_containers,
                                    gross_weight: _editedLot.gross_weight,
                                    leaf_grade: _editedLot.leaf_grade,
                                    water: _editedLot.water,
                                    course_leaf: _editedLot.course_leaf,
                                    other: _editedLot.other);
                              },
                            ),
                            SizedBox(
                              width: mediaQuery.width * 0.005,
                            ),
                            InputField(
                              labelText: 'No of Containers',
                              width: width,
                              editingController: _containerNoController,
                              validator: [FormBuilderValidators.required()],
                              onSave: (value) {
                                _editedLot = Lot(
                                    container_type: _editedLot.container_type,
                                    no_of_containers: int.parse(value),
                                    gross_weight: _editedLot.gross_weight,
                                    leaf_grade: _editedLot.leaf_grade,
                                    water: _editedLot.water,
                                    course_leaf: _editedLot.course_leaf,
                                    other: _editedLot.other);
                              },
                              keytype: TextInputType.number,
                            ),
                            SizedBox(
                              width: mediaQuery.width * 0.005,
                            ),
                            InputField(
                              labelText: 'Gross weight',
                              width: width,
                              validator: [FormBuilderValidators.required()],
                              onSave: (value) {
                                _editedLot = Lot(
                                    container_type: _editedLot.container_type,
                                    no_of_containers:
                                        _editedLot.no_of_containers,
                                    gross_weight: int.parse(value),
                                    leaf_grade: _editedLot.leaf_grade,
                                    water: _editedLot.water,
                                    course_leaf: _editedLot.course_leaf,
                                    other: _editedLot.other);
                              },
                              keytype: TextInputType.number,
                            ),
                            SizedBox(
                              width: mediaQuery.width * 0.005,
                            ),
                            InputField(
                              labelText: 'Leaf Grade',
                              width: width,
                              validator: [FormBuilderValidators.required()],
                              onSave: (value) {
                                _editedLot = Lot(
                                    container_type: _editedLot.container_type,
                                    no_of_containers:
                                        _editedLot.no_of_containers,
                                    gross_weight: _editedLot.gross_weight,
                                    leaf_grade: value,
                                    water: _editedLot.water,
                                    course_leaf: _editedLot.course_leaf,
                                    other: _editedLot.other);
                              },
                              keytype: TextInputType.number,
                            ),
                            SizedBox(
                              width: mediaQuery.width * 0.005,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: const Text(
                          'DEDUCTIONS',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 10,
                          ),
                        ),
                      ),
                      Container(
//                      color: Colors.blue,
                        height: mediaQuery.height * 0.4,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputField(
                                labelText: 'Water %',
                                width: deduct_width,
                                validator: [FormBuilderValidators.required()],
                                onSave: (value) {
                                  _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: int.parse(value),
                                      course_leaf: _editedLot.course_leaf,
                                      other: _editedLot.other);
                                },
                                keytype: TextInputType.number,
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.05,
                              ),
                              InputField(
                                labelText: 'Course Leaf %',
                                width: deduct_width,
                                validator: [FormBuilderValidators.required()],
                                onSave: (value) {
                                  _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: int.parse(value),
                                      other: _editedLot.other);
                                },
                                keytype: TextInputType.number,
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.05,
                              ),
                              InputField(
                                labelText: 'Other %',
                                width: deduct_width,
                                validator: [FormBuilderValidators.required()],
                                onSave: (value) {
                                  _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: _editedLot.course_leaf,
                                      other: int.parse(value));
                                },
                                keytype: TextInputType.number,
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
              height: mediaQuery.height * 0.05,
              child: RaisedButton.icon(
                onPressed: saveLot,
                icon: const Icon(Icons.add),
                label: const Text(
                  'SAVE',
                  style: const TextStyle(fontSize: 20),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
