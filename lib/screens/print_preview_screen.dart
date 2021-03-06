import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/widgets/card_container_printing_screen.dart';
import 'package:teatracker/constants.dart';

class PrintPreviewScreen extends StatefulWidget {
  @override
  _PrintPreviewScreenState createState() => _PrintPreviewScreenState();
}

class _PrintPreviewScreenState extends State<PrintPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final getCurrDate = provider.getCurrentDate();
    final deductions = provider.totalDeducts();

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TeaCollections>(
                  child: Center(
                    child: const Text(
                      'Got no lots yet',
                      style: kTextStyle,
                    ),
                  ),
                  builder: (ctx, teaCollections, ch) => teaCollections
                              .lot_items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: teaCollections.lot_items.length,
                          itemBuilder: (ctx, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardContainer(
                                mediaQuery: mediaQuery,
                                lotData:
                                    teaCollections.lot_items[i].container_type,
                                labelText: 'Container type',
                              ),
                              CardContainer(
                                  mediaQuery: mediaQuery,
                                  lotData:
                                      teaCollections.lot_items[i].leaf_grade,
                                  labelText: 'Grade of GL'),
                              CardContainer(
                                  mediaQuery: mediaQuery,
                                  lotData: teaCollections
                                      .lot_items[i].no_of_containers,
                                  labelText: 'Containers'),
                              CardContainer(
                                  mediaQuery: mediaQuery,
                                  lotData:
                                      teaCollections.lot_items[i].gross_weight,
                                  labelText: 'Gross Weight'),
                            ],
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
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: Container(
                height: mediaQuery.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: mediaQuery.width * 0.2,
                      height: mediaQuery.height * 0.1,
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: const Color(0xFF2E7D32),
                        child: Center(
                          child: Text(
                            getCurrDate,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Total deductions',
                      style: TextStyle(
                          color: const Color(0xFF1B5E20),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Container(
                      width: mediaQuery.width * 0.2,
                      height: mediaQuery.height * 0.1,
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: const Color(0xFF2E7D32),
                        child: Center(
                          child: Text(
                            "$deductions KG",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: mediaQuery.height * 0.05,
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "PrintScreen");
                  // Navigator.popUntil(
                  //   context,
                  //   ModalRoute.withName("MainMenuScreen"),
                  // );
                },
                icon: const Icon(Icons.print),
                label: const Text(
                  'PRINT',
                  style: TextStyle(fontSize: 20),
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
