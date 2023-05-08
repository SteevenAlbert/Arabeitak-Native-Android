import 'dart:io' show Platform;

import "package:path/path.dart" show dirname;
import 'package:arabeitak_flutter_ui/repositories/pdf_parsing/script.py';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:dartpy/dartpy.dart';
import 'package:dartpy/dartpy_annotations.dart';

String cd = dirname(Platform.script.toString());
String inPDF = "2016_toyota_corolla.pdf";
String inPDFpath = "$cd\\$inPDF";

class Instructions {
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

  // print(inPDFpath) {
  //   // TODO: implement print
  //   throw UnimplementedError();
  // }

  @PyFunction(module: 'script', name: 'get_instructions_from_manual')
  get_instructions_from_manual(String inPDFpath, List<String> keywords) =>
      get_instructions_from_manual(inPDFpath, keywords);

  pprint(get_instructions_from_manual(inPDFpath, keywords)) {
    // TODO: implement pprint
    throw UnimplementedError();
  }
}
