import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            decoration: InputDecoration(labelText: 'Water'),
            controller: _waterLevelController,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            decoration: InputDecoration(labelText: 'Course leaf'),
            controller: _courseLeafController,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            decoration: InputDecoration(labelText: 'Other'),
            controller: _otherDeductController,
          ),
        ),
      ],
    );
  }
}
