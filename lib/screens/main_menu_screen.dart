import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
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
                  Navigator.of(context).pushNamed('SupplierInputScreen');
                },
                child: Text("New Lot",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
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
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.3,
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).accentColor,
              child: MaterialButton(
                minWidth: mediaQuery.width * 0.01,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  Navigator.of(context).pushNamed('SupplierInputScreen');
                },
                child: Text("SYNCING",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
