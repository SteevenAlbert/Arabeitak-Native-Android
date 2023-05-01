import 'package:flutter/material.dart';
import 'package:arabeitak_flutter_ui/repositories/car.dart';

String? selectedCardModel = "";
String? selectedMake = "";
String? selectedYear = "";

class SelectCarModelPage extends StatefulWidget {
  const SelectCarModelPage({Key? key}) : super(key: key);

  @override
  State<SelectCarModelPage> createState() => _SelectCarModelPageState();
}

class _SelectCarModelPageState extends State<SelectCarModelPage> {
  onCarModelChanged(String? value) {
    if (value != selectedCardModel) selectedMake = "";
    setState(() {
      selectedCardModel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //TODO: car name field + UI + saving car (decline if car not supported)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // DropdownMenu(
              //     value: selectedCardModel,
              //     list: Car.carsList.keys,
              //     onChanged: onCarModelChanged),
              DropdownButton<String?>(
                  value: selectedCardModel,
                  items: Car.carsList.keys.map((e1) {
                    return DropdownMenuItem<String?>(
                      value: e1,
                      child: Text(e1),
                    );
                  }).toList(),
                  onChanged: onCarModelChanged),
              // DropdownMenu(
              //     value: selectedMake,
              //     list: (Car.carsList[selectedCardModel] ?? []),
              //     onChanged: (val) {
              //       setState(() {
              //         selectedMake = val!;
              //       });
              //     }),
              DropdownButton<String?>(
                  value: selectedMake,
                  items: (Car.carsList[selectedCardModel] ?? []).map((e2) {
                    return DropdownMenuItem<String?>(
                      value: e2,
                      child: Text(e2),
                    );
                  }).toList(),
                  onChanged: (val2) {
                    setState(() {
                      selectedMake = val2!;
                    });
                  }),
              // DropdownMenu(
              //     value: selectedYear,
              //     list: Car.yearList,
              //     onChanged: (val) {
              //       setState(() {
              //         selectedYear = val!;
              //       });
              //     }),
              DropdownButton<String?>(
                  value: selectedYear,
                  items: Car.yearList.map((e3) {
                    return DropdownMenuItem<String?>(
                      value: e3,
                      child: Text(e3),
                    );
                  }).toList(),
                  onChanged: (val3) {
                    setState(() {
                      selectedYear = val3!;
                    });
                  }),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 7,
                right: MediaQuery.of(context).size.height / 7),
            child: TextButton(
              onPressed: (() {
                Navigator.pushNamed(context, '/home');
              }),
              child: const Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
            ),
          )
        ]));
  }
}

//TODO: figure out why it doesn't work when put in a seperate custom widget 
// class DropdownMenu extends StatefulWidget {
//   String? value;
//   Iterable list;
//   Function(String?) onChanged;

//   DropdownMenu(
//       {super.key,
//       required this.value,
//       required this.list,
//       required this.onChanged});

//   @override
//   State<DropdownMenu> createState() => _DropdownMenuState();
// }

// class _DropdownMenuState extends State<DropdownMenu> {
//   late String? n = widget.value;
//   late var list = widget.list;
//   late Function(String?) onChanged = widget.onChanged;
//   late String dropdownValue = list.isNotEmpty ? list.first : "";

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String?>(
//         value: dropdownValue,
//         items: list.map<DropdownMenuItem<String?>>((e) {
//           return DropdownMenuItem<String?>(
//             value: e,
//             child: Text('$e'),
//           );
//         }).toList(),
//         onChanged: onChanged);
//   }
// }
