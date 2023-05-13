import "package:python_shell/python_shell.dart";
import "package:dartpy/dartpy.dart";
import "package:dartpy/dartpy_annotations.dart";
import 'dart:convert';
import 'package:ffi/ffi.dart';

runScript(String inPDFpath, List<String> keywords) async {
  // var shell = PythonShell(PythonShellConfig());
  // await shell.initialize().then((value) async {
  // print("Initializing done...");
  //   var instance = ShellManager.getInstance("default");
  //   instance.installRequires(["py_pdf_parser"]);
  //   await instance.runString('''
  dartpyc.Py_Initialize();
  print("Initializing done...");
  final python = '''
 
  print($inPDFpath)
  from py_pdf_parser.loaders import load_file
  from pprint import pprint
  import os
 
  document = load_file($inPDFpath)

  elements = document.elements.filter_by_text_contains(${keywords[0]})
  for key in $keywords:
      elements = elements.__or__(document.elements.filter_by_text_contains(key))

  h_elements = elements.filter_by_fonts('Arial-BoldMT,10.5','Arial-Black,14.0')

  flag =  False
  inst_elements = [] #Vehicles with a smart key system
  inst2_elements = [] #Vehicles without a smart key system
  tools_elements = []
  blacklist =["Downloaded from manualsnet.com search engine", "COROLLA_TMMMS_TMMC_U (OM12J84U)", "The air conditioning filter must be changed regularly to maintain\nair conditioning efficiency.", "Removal method","Replace the battery with a new one if it is depleted.","You will need the following items:", "Replacing the battery", "Head restraints are provided for all seats.", "Adjustment procedure", "Use the overhead switches to open and close the moon roof and\ntilt it up and down.", "Warning lights inform the driver of malfunctions in the indicated vehicle’s\nsystems."]
  breaks = ["CAUTION","n Checking interval", "n Use a CR2016 (vehicles without a smart key system) or CR2032 (vehicles", "n The moon roof can be operated when", "*1: Vehicles without a smart key system:"]
  exc = ["\uf075 Flat dipstick", "\uf075 Non-flat dipstick"]
  prev = -1
  pages = []
  for element in h_elements:
      for e in document.elements.below(element, all_pages=True):
          if e.text() in breaks:
              break
          if e.text().split()[0] != "n" and e.text() not in blacklist:
              if e.font_name != "Arial-BoldMT":
                  if e.text().split()[0] == "l"  or (prev != -1 and prev.text().split()[0] == "l"):
                      tools_elements.append(e)
                      pages.append(e.page_number)
                  else: 
                      if  e.text().split()[0] == "\uf075" and e.text()not in exc: 
                          flag = not flag
                          continue
                      if flag == False:
                          inst_elements.append(e)  
                          if e.page_number not in pages:
                              pages.append(e.page_number)
                      else:
                          inst2_elements.append(e)
                          if e.page_number not in pages:
                              pages.append(e.page_number)
              else:     
                  break   
          prev = e

  inst = "\n".join(e.text() for e in inst_elements)
  inst2 = "\n".join(e.text() for e in inst2_elements)
  tools = "\n".join(e.text() for e in tools_elements)

  output = {
      "source": "manual",
      "instructions": inst,
      "instructions 2": inst2,
      "tools/parts": tools,
      "pages": pages
  }

  pprint(output)
  ''';
  final pystring = python.toNativeUtf8();
  dartpyc.PyRun_SimpleString(pystring.cast<Int8>());
  malloc.free(pystring);
  print(dartpyc.Py_FinalizeEx());

// ''').then((value) {
//       return "Parsing done...";
//     });
//   });
}
