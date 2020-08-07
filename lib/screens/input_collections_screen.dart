import 'package:flutter/material.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  //stored textfield values to below variable
  final _suplierController = TextEditingController();
  final _containerTypeController = TextEditingController();
  final _containerNoController = TextEditingController();
  final _grossWeightController = TextEditingController();
  final _leafGradeController = TextEditingController();
  final _boxNoController = TextEditingController();
  final _waterLevelController = TextEditingController();
  final _courseLeafController = TextEditingController();
  final _otherDeductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter the data'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Supplier no'),
                      controller: _suplierController,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Type of container'),
                      controller: _containerTypeController,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'No of containers'),
                      controller: _containerNoController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Gross weight'),
                      controller: _grossWeightController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Leaf grade'),
                      controller: _leafGradeController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Box no'),
                      controller: _boxNoController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Water'),
                      controller: _waterLevelController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Course leaf'),
                      controller: _courseLeafController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Other'),
                      controller: _otherDeductController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Save'),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
