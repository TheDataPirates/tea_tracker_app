import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/widgets/card_container_printing_screen.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  var deductions;
  Future<void> totalDeducts() async {
    final deducts = Provider.of<TeaCollections>(context, listen: false)
        .lot_items; // getting saved lot from SQLDB
    try {
      int total = 0;
      deducts.forEach(
          (item) => {total += item.water + item.course_leaf + item.other});
      print(total);
      setState(() {
        deductions = total;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => totalDeducts()); //calling above method when creating this screen
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: Provider.of<TeaCollections>(context, listen: false)
                      .fetchAndSetLotData(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Consumer<TeaCollections>(
                              child: Center(
                                child: const Text('Got no lots yet'),
                              ),
                              builder: (ctx, teaCollections, ch) =>
                                  teaCollections.lot_items.length <= 0
                                      ? ch
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                              teaCollections.lot_items.length,
                                          itemBuilder: (ctx, i) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CardContainer(
                                                mediaQuery: mediaQuery,
                                                lotData: teaCollections
                                                    .lot_items[i]
                                                    .container_type,
                                                labelText: 'Container type',
                                              ),
                                              CardContainer(
                                                  mediaQuery: mediaQuery,
                                                  lotData: teaCollections
                                                      .lot_items[i].leaf_grade,
                                                  labelText: 'Grade of GL'),
                                              CardContainer(
                                                  mediaQuery: mediaQuery,
                                                  lotData: teaCollections
                                                      .lot_items[i]
                                                      .no_of_containers,
                                                  labelText:
                                                      'Number of Containers'),
                                              CardContainer(
                                                  mediaQuery: mediaQuery,
                                                  lotData: teaCollections
                                                      .lot_items[i]
                                                      .gross_weight,
                                                  labelText: 'Gross Weight'),
                                            ],
                                          ),
                                        ),
                            ),
                ),
              ),
            ),
            Container(
              child: Text(
                'DEDUCTIONS',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 15,
                ),
              ),
            ),
            Container(
              height: mediaQuery.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total deductions '),
                  Text("$deductions"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
