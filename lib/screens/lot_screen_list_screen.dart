import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/screens/list_tile_lot_screen.dart';

class LotListScreen extends StatefulWidget {
  final supplierID;
  final supplierName;

  const LotListScreen({Key key, this.supplierID, this.supplierName})
      : super(key: key);

  @override
  _LotListScreenState createState() => _LotListScreenState();
}

class _LotListScreenState extends State<LotListScreen> {
  @override
  Widget build(BuildContext context) {
//    final currentSupplier =
//        Provider.of<TeaCollections>(context, listen: false).newSupplier;
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ${widget.supplierID}    NAME: ${widget.supplierName}'),
        actions: [
          IconButton(
            tooltip: "printing",
            icon: Icon(
              Icons.print,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("PrintScreen");
            },
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
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
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
          Navigator.pushNamed(context, "InputCollectionScreen");
        },
      ),
    );
  }
}
