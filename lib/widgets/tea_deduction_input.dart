import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TeaDeductionInput extends StatefulWidget {
  @override
  _TeaDeductionInputState createState() => _TeaDeductionInputState();
}

class _TeaDeductionInputState extends State<TeaDeductionInput> {
  //stored textfield values to below variable

  final _waterLevelController = TextEditingController();
  final _courseLeafController = TextEditingController();
  final _otherDeductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = 0.2;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * width,
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
            width: MediaQuery.of(context).size.width * width,
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
            width: MediaQuery.of(context).size.width * width,
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
    );
  }
}
