import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/screens/list_tile_lot_screen.dart';
import 'package:teatracker/screens/lot_screen_list_screen.dart';
import 'package:teatracker/screens/print_screen.dart';
import 'package:teatracker/screens/supplier_input_screen.dart';
import 'screens//login_Screen.dart';
import 'screens/input_collections_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // set lock to landscape view only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeaCollections(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.greenAccent,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 53, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            headline6: TextStyle(
                fontSize: 36.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
            bodyText1: TextStyle(fontSize: 24.0),
            bodyText2: TextStyle(fontSize: 14.0),
          ),
        ),
        home: LoginScreen(),
        routes: {
          'InputCollectionScreen': (ctx) => InputCollectionScreen(),
          'LotListScreen': (ctx) => LotListScreen(),
          'ListTileLotScreen': (ctx) => ListTileLot(),
          'SupplierInputScreen': (ctx) => SupplierInputScreen(),
          'PrintScreen': (ctx) => PrintScreen()
        },
      ),
    );
  }
}
