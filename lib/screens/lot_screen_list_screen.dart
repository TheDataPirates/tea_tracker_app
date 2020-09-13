import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LotListScreen extends StatefulWidget {
  @override
  _LotListScreenState createState() => _LotListScreenState();
}

class _LotListScreenState extends State<LotListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tea Collections'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("InputCollectionScreen");
            },
          )
        ],
      ),
    );
  }
}
