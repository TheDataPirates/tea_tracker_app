import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';

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
      body: Consumer<TeaCollections>(
        child: Center(
          child: const Text('Got no lots yet, start adding some!'),
        ),
        builder: (ctx, teaCollections, ch) => teaCollections.lot_items.length <=
                0
            ? ch
            : ListView.builder(
                itemCount: teaCollections.lot_items.length,
                itemBuilder: (ctx, i) => Card(
                  elevation: 10.0,
                  child: ListTile(
                    leading: Icon(Icons.insert_emoticon),
                    title: Text(teaCollections.lot_items[i].supplier_id),
                    subtitle: Text(teaCollections.lot_items[i].container_type),
                    trailing: Icon(Icons.more_vert),
                    onTap: () {
                      // Go to detail page ...
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
