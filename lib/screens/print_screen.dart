import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:provider/provider.dart';
import 'package:teatracker/providers/tea_collections.dart';
import 'package:teatracker/constants.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  PrinterBluetoothManager _printerBluetoothManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  // ignore: must_call_super
  void initState() {
    bluetoothManager.state.listen((val) {
      print(val);
      if (!mounted) return;
      if (val == 12) {
        print("on");
        initPrinter();
      } else if (val == 10|| val == 0) {
        print("off");
        setState(() {
          _devicesMsg = 'Bluetooth is off';
        });
      }
    });
  }

  void initPrinter() {
    _printerBluetoothManager.startScan(Duration(seconds: 2));
    _printerBluetoothManager.scanResults.listen((val) {
      if (!mounted) {
        print('not mounted');
        return;
      }
      setState(() => _devices = val);
      // print(_devices);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerBluetoothManager.selectPrinter(printer);
    final result = await _printerBluetoothManager
        .printTicket(await _ticket(PaperSize.mm58));
    print(result);
  }

  Future<Ticket> _ticket(PaperSize _paperSize) async {
    final ticket = Ticket(_paperSize);
    ticket.text("text");
    ticket.cut();
    return ticket;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeaCollections>(context, listen: false);
    // final getCurrDate = provider.getCurrentDate();
    // final deductions = provider.totalDeducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: _devices.isEmpty
            ? Center(
                child: Text(_devicesMsg ?? ''),
              )
            : ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (ctx, i) => Card(
                  color: kCardColor,
                  elevation: 10.0,
                  child: ListTile(
                    leading: Icon(
                      Icons.print,
                      size: 70,
                    ),
                    title: Text(
                      _devices[i].name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    subtitle: Text(_devices[i].address),
                    onTap: () {
                      print(_devices[i]);
                      _startPrint(_devices[i]);
                      // Navigator.popUntil(
                      //   context,
                      //   ModalRoute.withName("MainMenuScreen"),
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ListTileLot(
                      //       lot_id: teaCollections.lot_items[i].lotId,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
