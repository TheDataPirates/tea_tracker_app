import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teatracker/constants.dart';

class TeaAcquiringInput extends StatefulWidget {
  @override
  _TeaAcquiringInputState createState() => _TeaAcquiringInputState();
}

class _TeaAcquiringInputState extends State<TeaAcquiringInput> {
  final _supplierController = TextEditingController();
  final _containerTypeController = TextEditingController();
  final _containerNoController = TextEditingController();
  final _grossWeightController = TextEditingController();
  final _leafGradeController = TextEditingController();
  final _boxNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = 0.15;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width * width,
          child: TextField(
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
          ),
        ),
      ],
    );
  }
}
