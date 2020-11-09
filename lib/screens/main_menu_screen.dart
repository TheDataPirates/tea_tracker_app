import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';

class MainMenuScreen extends StatelessWidget {
  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
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
                      color: Theme.of(context).accentColor,
                      child: MaterialButton(
                        minWidth: mediaQuery.width * 0.4,
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
                      color: Theme.of(context).accentColor,
                      child: MaterialButton(
                        minWidth: mediaQuery.width * 0.4,
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
                      color: Theme.of(context).accentColor,
                      child: MaterialButton(
                        minWidth: mediaQuery.width * 0.01,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('SupplierInputScreen');
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
    );
  }
}
