import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teatracker/constants.dart';

class TeaAcquiringInput {
  static final _supplierController = TextEditingController();
  static final _containerTypeController = TextEditingController();
  static final _containerNoController = TextEditingController();
  static final _grossWeightController = TextEditingController();
  static final _leafGradeController = TextEditingController();
  static final _boxNoController = TextEditingController();

  static final supplier_no = TextField(
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
  static final container_type = TextField(
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
  static final no_of_container = TextField(
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
  static final gross_weight = TextField(
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
  static final leaf_grade = TextField(
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

  //getters for controllers
  static get supplierController => _supplierController;

  static get containerTypeController => _containerTypeController;

  static get containerNoController => _containerNoController;

  static get grossWeightController => _grossWeightController;

  static get leafGradeController => _leafGradeController;

  static get boxNoController => _boxNoController;
}
