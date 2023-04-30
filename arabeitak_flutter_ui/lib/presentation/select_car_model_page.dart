import 'package:flutter/material.dart';
import 'package:arabeitak_flutter_ui/repositories/car.dart';

String value1 = "";
int? list2index = -1;
List<dynamic> list2 = [""];
String value2 = "";
String value3 = "";

class SelectCarModelPage extends StatefulWidget {
  SelectCarModelPage({super.key});

  @override
  State<SelectCarModelPage> createState() => _SelectCarModelPageState();
}

class _SelectCarModelPageState extends State<SelectCarModelPage> {
  final ValueNotifier<List<dynamic>> _list2notifier =
      ValueNotifier<List<dynamic>>(list2);

  refresh() {
    setState(() {
      list2index = Car.carsList.indexWhere((c) => c.containsKey(value1));
      list2 = Car.carsList
          .elementAt(list2index!)
          .values
          .map((e) => e.toString().substring(1, e.toString().length - 1))
          .toList();
      _list2notifier.value = list2;
      print(list2);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: car name field + UI + saving car (decline if car not supported)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            DropdownMenu(
              n: 1,
              list: Car.carsList
                  .map((e) => e.keys
                      .toString()
                      .substring(1, e.keys.toString().length - 1))
                  .toList(),
              notify: refresh,
            ),
            ValueListenableBuilder<List<dynamic>>(
              valueListenable: _list2notifier,
              builder: (context, list, child) {
                return DropdownMenu(
                  n: 2,
                  list: list,
                  listnotifier: _list2notifier,
                  notify: refresh,
                );
                // return Text(list.toString());
              },
            ),
            DropdownMenu(
              n: 3,
              list: Car.yearList,
              notify: refresh,
            )
          ]),
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
        ],
      ),
    );
  }
}

class DropdownMenu extends StatefulWidget {
  int n;
  final List list;
  ValueNotifier<List<dynamic>>? listnotifier;
  Function() notify;

  DropdownMenu(
      {super.key,
      required this.n,
      required this.list,
      this.listnotifier,
      required this.notify});

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late List list = widget.list;
  late int? n = widget.n;
  late Function() notify = widget.notify;
  late String dropdownValue = list.isNotEmpty ? list.first : "";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      items: list.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (String? value) {
        if (n == 1) {
          dropdownValue = value!;
          value1 = value;
          notify();
        } else if (n == 2) {
          value2 = value!;
          dropdownValue = value;
        } else if (n == 3) {
          dropdownValue = value!;
          value3 = value;
        }
        //TODO: second drop down menu not updating
        setState(() {});
      },
    );
  }
}
