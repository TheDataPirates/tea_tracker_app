import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/screens/list_tile_lot_screen.dart';

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
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text(
                                "${teaCollections.lot_items[i].leaf_grade}")),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(teaCollections.lot_items[i].supplier_id),
                        Text("${teaCollections.lot_items[i].gross_weight}")
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(teaCollections.lot_items[i].container_type),
                        Text("${teaCollections.lot_items[i].no_of_containers}")
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListTileLot(
                            supplier_id:
                                teaCollections.lot_items[i].supplier_id,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
