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
                      child: TeaAcquiringInput(),
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
                      child: TeaDeductionInput(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text(
                'SAVE',
                style: TextStyle(fontSize: 20),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
