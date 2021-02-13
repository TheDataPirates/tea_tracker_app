import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/models/lot.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/widgets/tea_acquiring_input.dart';
import 'package:intl/intl.dart';
import 'package:teatracker/constants.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  Future<void> _showMyDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              title: const Text('Warning !'),
              content: ListBody(
                children: <Widget>[
                  const Text('Your are missing or added extra container'),
                  const Text('Please try again'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var count = 0;
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  var _editedLot = Lot(
      container_type: '',
      no_of_containers: 0,
      gross_weight: 0,
      leaf_grade: '',
      water: 0,
      course_leaf: 0,
      other: 0,
      container1: 0,
      container2: 0,
      container3: 0,
      container4: 0,
      container5: 0);

  String noOfControllers;

  @override
  void dispose() {
    super.dispose();
  }

  //media query width for row
  final double width = 0.2;
  final double deduct_width = 0.2;

  Future<void> saveLot() async {
    if (_fbkey.currentState.validate()) {
      _fbkey.currentState
          .save(); //save func will trigger count++ inside itself.
      if (count == int.parse(noOfControllers)) {
        //check here no of containers is equal to entered containers
        print(noOfControllers);
        print(count);
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
                _editedLot.container_type,
                _editedLot.no_of_containers),
            provider.calNetWeight(
              _editedLot.gross_weight,
            ),
            provider.getCurrentDate(),
            _editedLot.container1,
            _editedLot.container2,
            _editedLot.container3,
            _editedLot.container4,
            _editedLot.container5 //get current data & save
            );
        Navigator.of(context).pop();
      } else {
        count =
            0; //count should be 0 if not after click okay condition not true
        _showMyDialog();
        print('not valid');
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: FormBuilder(
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
                          height: mediaQuery.height * 0.3,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                color: kColor,
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kColor,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  width: mediaQuery.width * width,
                                  child: FormBuilderDropdown(
                                    attribute: "Container Type",
                                    decoration: InputDecoration(
                                      labelText: " Container Type",
                                      errorStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 40.0),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(13.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    // initialValue:

                                    validators: [
                                      FormBuilderValidators.required(),
                                      // ignore: missing_retur
                                    ],
                                    items: ['A', 'B', 'C', 'D', 'E']
                                        .map((container) => DropdownMenuItem(
                                            value: container,
                                            child: Text("$container")))
                                        .toList(),
                                    onSaved: (value) {
                                      _editedLot = Lot(
                                        container_type: value,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kColor,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  width: mediaQuery.width * width,
                                  child: FormBuilderDropdown(
                                    attribute: "No of Containers",
                                    decoration: InputDecoration(
                                      labelText: " No of Containers",
                                      errorStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 40.0),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(13.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    // initialValue:

                                    validators: [
                                      FormBuilderValidators.required(),
                                      // ignore: missing_return
                                      (val) {
                                        if (!val.isEmpty) {
                                          noOfControllers = val;
                                        }
                                        return null;
                                      },
                                    ],
                                    items: ['1', '2', '3', '4', '5']
                                        .map((container) => DropdownMenuItem(
                                            value: container,
                                            child: Text("$container")))
                                        .toList(),
                                    onSaved: (value) {
                                      _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers: int.parse(value),
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kColor,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  width: mediaQuery.width * width,
                                  child: FormBuilderDropdown(
                                    attribute: "Grade of GL",
                                    decoration: InputDecoration(
                                      labelText: " Grade of GL",
                                      errorStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 40.0),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(13.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    // initialValue:

                                    validators: [
                                      FormBuilderValidators.required(),
                                      // ignore: missing_retur
                                    ],
                                    items: ['A', 'B', 'C']
                                        .map((container) => DropdownMenuItem(
                                            value: container,
                                            child: Text("$container")))
                                        .toList(),
                                    onSaved: (value) {
                                      _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: value,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                              InputField(
                                labelText: ' Gross weight',
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
                                    other: _editedLot.other,
                                    container1: _editedLot.container1,
                                    container2: _editedLot.container2,
                                    container3: _editedLot.container3,
                                    container4: _editedLot.container4,
                                    container5: _editedLot.container5,
                                  );
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
                          height: mediaQuery.height * 0.2,
                          padding: EdgeInsets.only(top: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InputField(
                                labelText: ' Container 1',
                                width: 0.15,
                                // ignore: missing_return
                                validator: [],
                                onSave: (value) {
                                  if (!value.isEmpty) {
                                    count += 1;
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: int.parse(value),
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container3,
                                        container5: _editedLot.container5);
                                  } else {
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5);
                                  }
                                },
                                keytype: TextInputType.number,
                              ),
                              InputField(
                                labelText: ' Container 2',
                                width: 0.15,
                                validator: [],
                                onSave: (value) {
                                  if (!value.isEmpty) {
                                    count += 1;
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: int.parse(value),
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container3,
                                        container5: _editedLot.container5);
                                  } else {
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5);
                                  }
                                },
                                keytype: TextInputType.number,
                              ),
                              InputField(
                                labelText: ' Container 3',
                                width: 0.15,
                                validator: [],
                                onSave: (value) {
                                  if (!value.isEmpty) {
                                    count += 1;
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: int.parse(value),
                                        container4: _editedLot.container3,
                                        container5: _editedLot.container5);
                                  } else {
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5);
                                  }
                                },
                                keytype: TextInputType.number,
                              ),
                              InputField(
                                labelText: ' Container 4',
                                width: 0.15,
                                validator: [],
                                onSave: (value) {
                                  if (!value.isEmpty) {
                                    count += 1;
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: int.parse(value),
                                        container5: _editedLot.container5);
                                  } else {
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5);
                                  }
                                },
                                keytype: TextInputType.number,
                              ),
                              InputField(
                                labelText: ' Container 5',
                                width: 0.15,
                                validator: [],
                                onSave: (value) {
                                  if (!value.isEmpty) {
                                    count += 1;
                                    _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: _editedLot.course_leaf,
                                      other: _editedLot.other,
                                      container1: _editedLot.container1,
                                      container2: _editedLot.container2,
                                      container3: _editedLot.container3,
                                      container4: _editedLot.container3,
                                      container5: int.parse(value),
                                    );
                                  } else {
                                    _editedLot = Lot(
                                        container_type:
                                            _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                        container1: _editedLot.container1,
                                        container2: _editedLot.container2,
                                        container3: _editedLot.container3,
                                        container4: _editedLot.container4,
                                        container5: _editedLot.container5);
                                  }
                                },
                                keytype: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: mediaQuery.height * 0.1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: const Text(
                                'DEDUCTIONS',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
//                      color: Colors.blue,
                          height: mediaQuery.height * 0.3,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputField(
                                  labelText: ' Water %',
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
                                      other: _editedLot.other,
                                      container1: _editedLot.container1,
                                      container2: _editedLot.container2,
                                      container3: _editedLot.container3,
                                      container4: _editedLot.container4,
                                      container5: _editedLot.container5,
                                    );
                                  },
                                  keytype: TextInputType.number,
                                ),
                                SizedBox(
                                  width: mediaQuery.width * 0.05,
                                ),
                                InputField(
                                  labelText: ' Course Leaf %',
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
                                      other: _editedLot.other,
                                      container1: _editedLot.container1,
                                      container2: _editedLot.container2,
                                      container3: _editedLot.container3,
                                      container4: _editedLot.container4,
                                      container5: _editedLot.container5,
                                    );
                                  },
                                  keytype: TextInputType.number,
                                ),
                                SizedBox(
                                  width: mediaQuery.width * 0.05,
                                ),
                                InputField(
                                  labelText: ' Other %',
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
                                      other: int.parse(value),
                                      container1: _editedLot.container1,
                                      container2: _editedLot.container2,
                                      container3: _editedLot.container3,
                                      container4: _editedLot.container4,
                                      container5: _editedLot.container5,
                                    );
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
      ),
    );
  }
}
