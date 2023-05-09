import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:arabeitak_flutter_ui/repositories/procedures.dart';

import '../main.dart';

Map<String, List<String>> convertToMap(String e) {
  String dataSp = e.trim().substring(1, e.length - 1);
  String key = dataSp.split(':')[0];
  String value = dataSp.split(':')[1].trim();
  List<String> valueList = value.substring(1, value.length - 1).split(',');
  valueList = valueList.map((e) => e.trim()).toList();
  Map<String, List<String>> mapData = {};
  mapData[key] = valueList;
  return mapData;
}

Iterable<String> sections = Procedures.proceduresList.keys;

class ARList extends StatelessWidget {
  const ARList({super.key});

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
      body: SafeArea(
        left: true,
        child: Row(
          children: [
            Image(
              image: const AssetImage("assets/images/hologram.png"),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
            ),
            // ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 10),
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  labelPadding: const EdgeInsets.all(10),
                ),
                tabs: [
                  for (String e in sections)
                    Text(
                      (e.split(" ").take(3)).join(" "),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                ],
                views: [
                  for (var i = 0; i < sections.length; i++)
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 15,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                ListTile.divideTiles(context: context, tiles: [
                              if (Procedures
                                      .proceduresList[sections.elementAt(i)] !=
                                  null)
                                for (var e in Procedures
                                    .proceduresList[sections.elementAt(i)]!)
                                  if (e.runtimeType == String)
                                    CustomListTile(
                                        context: context,
                                        icon: e.toString().replaceAll('/', ''),
                                        text: e.toString(),
                                        path:
                                            'ar_${e.toString().toLowerCase().replaceAll('/', '').replaceAll(' ', '_')}')
                                  else
                                    for (String v in convertToMap(e.toString())
                                        .values
                                        .first)
                                      CustomListTile(
                                          context: context,
                                          icon:
                                              'ar_${convertToMap(e.toString()).keys.first} $v'
                                                  .replaceAll('/', ''),
                                          text:
                                              '${convertToMap(e.toString()).keys.first} $v',
                                          path:
                                              '${convertToMap(e.toString()).keys.first} $v'
                                                  .toLowerCase()
                                                  .replaceAll('/', '')
                                                  .replaceAll(' ', '_'))
                            ]).toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomListTile(
    {required BuildContext context,
    required String icon,
    required String text,
    required String path}) {
  return Container(
    height: MediaQuery.of(context).size.height / 7,
    // padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 57),
    child: ListTile(
      onTap: () => navigateToPage(path),
      title: Row(
        //TODO: fix overflow
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageIcon(
            AssetImage("assets/icons/$icon.png"),
            color: Colors.black87,
            size: MediaQuery.of(context).size.height / 15,
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 25,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
      trailing: SizedBox(
        height: MediaQuery.of(context).size.height / 19,
        width: MediaQuery.of(context).size.width / 15,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: Colors.black87),
            onPressed: () {
              if (path == null) {
              } else {
                () => navigateToPage('/$path');
              }
            },
            child: Icon(
              Icons.arrow_forward,
              size: MediaQuery.of(context).size.height / 21,
            )),
      ),
    ),
  );
}
