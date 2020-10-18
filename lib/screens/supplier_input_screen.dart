import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SupplierInputScreen extends StatelessWidget {
  final supplierNoEditingController = TextEditingController();
  final supplierNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: supplierNoEditingController,
                      obscureText: false,
                      style: TextStyle(fontSize: 40.0),
                      decoration: InputDecoration(
                        labelText: "Supplier No :",
                        labelStyle: kTextFieldLabelStyle,
                        fillColor: Colors.lightGreen,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: supplierNameEditingController,
                      style: TextStyle(fontSize: 40.0),
                      decoration: InputDecoration(
                        fillColor: Colors.lightGreen,
                        filled: true,
                        labelStyle: kTextFieldLabelStyle,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Supplier Name :",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
//            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed("LotListScreen");
              },
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
