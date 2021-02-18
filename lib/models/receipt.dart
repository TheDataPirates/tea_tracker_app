import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:date_time_format/date_time_format.dart';

class Receipt {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;


  sample(String agentName, String supId, String supName, int grossWeight, int totDeduct, int netWeight) async {
    DateTime dateTime = DateTime.now();
    var timeNow = dateTime.format('H:i');
    var dateNow = dateTime.format('d/m/Y');
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

//     var response = await http.get("IMAGE_URL");
//     Uint8List bytes = response.bodyBytes;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("Kudamalana Tea", 4, 1);
        bluetooth.printCustom("Factory", 4, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(dateNow.toString(), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(timeNow.toString(), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Agent Name :", agentName.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Supplier ID :", supId.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Supplier Name :", supName.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Gross Weight :", grossWeight.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Total Deduction", totDeduct.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Net Weight :", netWeight.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank You ...!", 3, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
