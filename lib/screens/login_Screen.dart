import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150.0,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(10.0),
            onPressed: () {
              Navigator.pushNamed(context, 'InputCollectionScreen');
            },
            child: Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(10.0),
            onPressed: () {},
            child: Text(
              'SIGN UP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
