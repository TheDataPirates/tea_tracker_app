import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/constants.dart';

class MainMenuScreen extends StatelessWidget {
  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0, fontStyle: FontStyle.italic);
  Future<void> _syncSqlLiteToMySql(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Your are going to syncing the lot'),
                const Text('Would you like to approve of this action?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                try {
                  await Provider.of<TeaCollections>(context, listen: false)
                      .syncLocalDb(
                          Provider.of<TeaCollections>(context, listen: false)
                              .getCurrentDate());
                  print('after sync');
                  Navigator.of(context).pop();
                } catch (e) {
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('AlertDialog'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(e.toString()),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName("MainMenuScreen"),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
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
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: kColor,
                        child: MaterialButton(
                          minWidth: mediaQuery.width * 0.4,
                          height: mediaQuery.height * 0.06,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('SupplierInputScreen');
                          },
                          child: Text("New Lot",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.05,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: kColor,
                        child: MaterialButton(
                          minWidth: mediaQuery.width * 0.4,
                          height: mediaQuery.height * 0.06,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            Navigator.of(context).pushNamed('AllLotsScreen');
                          },
                          child: Text("All Lots",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.2,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: kColor,
                        child: MaterialButton(
                          minWidth: mediaQuery.width * 0.01,
                          height: mediaQuery.height * 0.06,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            _syncSqlLiteToMySql(context);
                          },
                          child: Text("SYNCING",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
//            height: MediaQuery.of(context).size.height * 0.05,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.logout),
                label: Text(
                  'Hi ${provider.currUser.user_id}',
                  style: const TextStyle(fontSize: 30),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
