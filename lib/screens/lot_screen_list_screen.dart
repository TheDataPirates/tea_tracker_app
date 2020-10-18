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
            tooltip: "printing",
            icon: Icon(
              Icons.print,
              size: 40,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<TeaCollections>(context, listen: false)
            .fetchAndSetLotData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TeaCollections>(
                child: Center(
                  child: const Text('Got no lots yet, start adding some!'),
                ),
                builder: (ctx, teaCollections, ch) => teaCollections
                            .lot_items.length <=
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
                                  "${teaCollections.lot_items[i].leaf_grade}",
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                              ),
                            ),
                            title: Text(
                              "${teaCollections.lot_items[i].gross_weight} KG",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "Container type : ${teaCollections.lot_items[i].container_type} ->>",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  "  Units ${teaCollections.lot_items[i].no_of_containers}",
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              ],
                            ),
                            trailing: IconButton(
                              // deleting displayed lot by pass lot id
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                teaCollections.deleteLot(
                                    teaCollections.lot_items[i].lotId);
                              },
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("InputCollectionScreen");
        },
      ),
    );
  }
}
