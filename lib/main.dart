import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/screens/lot_screen_list_screen.dart';
import 'screens//login_Screen.dart';
import 'screens/input_collections_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TeaCollections(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.greenAccent,
        ),
        home: LoginScreen(),
        routes: {
          'InputCollectionScreen': (ctx) => InputCollectionScreen(),
          'LotListScreen': (ctx) => LotListScreen()
        },
      ),
    );
  }
}
