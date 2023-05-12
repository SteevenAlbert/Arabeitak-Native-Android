import 'dart:io' show Platform;

import "package:path/path.dart" show dirname;
import 'package:arabeitak_flutter_ui/repositories/pdf_parsing/script.dart';

String cd = dirname(Platform.script.toString());
String inPDF = "2016_toyota_corolla.pdf";
String inPDFpath = "$cd\\$inPDF";

// List<String> keywords= [ "Find Vehicle Identification Number", "VIN"];
// List<String> keywords= [ "Hood", "hood" ];
// List<String> keywords= [ "Battery", "battery" ]; //!!!
// List<String> keywords= [ "coolant" ];
// List<String> keywords = ["engine oil"];
// List<String> keywords = ["Brake fluid"];
// List<String> keywords = ["Windshield fluid", "windshield fluid"];
// List<String> keywords = ["Flat tire","flat tire"]; //!!!
// List<String> keywords = ["Wiper blades", "wiper blades"];
// List<String> keywords= [ "Headlights", "headlights"]; //!!!
// List<String> keywords = ["Front turn signal/parking lights"];
// List<String> keywords = ["rear turn signal lights"];
// List<String> keywords =["Stop/tail/rear side marker lights"];
// List<String> keywords = ["Brake lights", "brake lights"];
List<String> keywords = ["Air conditioning filter"];
// List<String> keywords = ["Wireless remote control/electronic key \nbattery"];
// List<String> keywords = ["Front seats"]; //!!!
// List<String> keywords = ["Folding down the rear seatbacks"];
// List<String> keywords = ["Head restraints"]; //???
// List<String> keywords = ["Outside rear view mirrors"];
// List<String> keywords = ["Moon roof"]; //???
// List<String> keywords = ["Warning lights","Warning light"];

class Instructions {
  get_instructions_from_manual() async {
    await runScript(inPDFpath, keywords).then((result) {
      print(result);
      return result;
    });
  }
}
