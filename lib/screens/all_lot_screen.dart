import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'list_tile_lot_screen.dart';
import 'package:teatracker/constants.dart';

class AllLotsScreen extends StatefulWidget {
  @override
  _AllLotsScreenState createState() => _AllLotsScreenState();
}

class _AllLotsScreenState extends State<AllLotsScreen> {
  Future<void> _showMyDialog(String id) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Your are going to delete the lot'),
                const Text('Would you like to approve of this action?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Provider.of<TeaCollections>(context, listen: false)
                    .deleteLot(id);

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDate =
        Provider.of<TeaCollections>(context, listen: false).getCurrentDate();
    return Scaffold(
      appBar: AppBar(
        title: Text('DATE: $currentDate'),
//        actions: [
//          IconButton(
//
//            icon: const Icon(
//              Icons.print,
//              size: 40,
//            ),
//            onPressed: () {
//              Navigator.popUntil(
//                context,
//                ModalRoute.withName("MainMenuScreen"),
//              );
//            },
//          )
//        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<TeaCollections>(context, listen: false)
              .fetchAndSetLotData(
                  currentDate), //fetching lot details which is deleted 0 & Date
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TeaCollections>(
                  child: Center(
                    child: const Text('Got no lots yet, start adding some!', style:kTextStyle),
                  ),
                  builder: (ctx, teaCollections, ch) => teaCollections
                              .lot_items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemCount: teaCollections.lot_items.length,
                          itemBuilder: (ctx, i) => Card(
                            color: const Color(0xFF66BB6A),
                            elevation: 10.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFF1B5E20),
                                radius: 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FittedBox(
                                    child: Text(
                                      "${teaCollections.lot_items[i].leaf_grade}",
                                      style:
                                      TextStyle(fontSize: 53, fontWeight: FontWeight.bold, color: Colors.white),
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
                                    "Supplier : ${teaCollections.lot_items[i].supplier_name} ->>",
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  Text(
                                    "  Units ${teaCollections.lot_items[i].no_of_containers}",
                                    style: Theme.of(context).textTheme.headline3,
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                iconSize: 50,
                                color: Colors.red,
                                // deleting displayed lot by pass lot id
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showMyDialog(
                                      teaCollections.lot_items[i].lotId);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListTileLot(
                                      lot_id: teaCollections.lot_items[i].lotId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.home, size: 40,),
        onPressed: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName("MainMenuScreen"),
          );
        },
      ),
    );
  }
}
