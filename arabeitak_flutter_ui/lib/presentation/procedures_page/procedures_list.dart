import 'package:arabeitak_flutter_ui/presentation/procedures_page/custom_list_tile.dart';
import 'package:arabeitak_flutter_ui/repositories/procedures.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

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

class ProceduresList extends StatelessWidget {
  const ProceduresList({super.key, required this.isPortrait});

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      height: !isPortrait
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height * 0.5,
      width: !isPortrait
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width,
      child: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          labelPadding: const EdgeInsets.all(8.0),
        ),
        tabs: [
          for (String e in sections)
            Text(
              (e.split(" ").take(3)).join(" "),
            ),
        ],
        views: [
          for (var i = 0; i < sections.length; i++)
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ListView(
                    shrinkWrap: true,
                    children: ListTile.divideTiles(context: context, tiles: [
                      if (Procedures.proceduresList[sections.elementAt(i)] !=
                          null)
                        for (var e in Procedures
                            .proceduresList[sections.elementAt(i)]!)
                          if (e.runtimeType == String)
                            CustomListTile(
                                icon: e.toString().replaceAll('/', ''),
                                text: e.toString(),
                                path:
                                    'ar_${e.toString().toLowerCase().replaceAll('/', '').replaceAll(' ', '_')}')
                          else
                            for (String v
                                in convertToMap(e.toString()).values.first)
                              CustomListTile(
                                  icon:
                                      '${convertToMap(e.toString()).keys.first} $v'
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
    );
  }
}
