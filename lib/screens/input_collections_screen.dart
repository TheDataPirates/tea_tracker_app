import 'package:flutter/material.dart';
import 'package:teatracker/widgets/tea_acquiring_input.dart';
import 'package:teatracker/widgets/tea_deduction_input.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
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
                    Container(
//                      color: Colors.amber,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: TeaAcquiringInput(),
                    ),
                    Container(
//                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: TeaDeductionInput(),
                    )
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
