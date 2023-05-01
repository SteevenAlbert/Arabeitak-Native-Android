import 'package:flutter/material.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

import '../main.dart';

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
      //TODO: update procedures list + UI
      body: SafeArea(
        left: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: const AssetImage("assets/images/hologram.png"),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
            ),
            // ),
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
                    children: ListTile.divideTiles(context: context, tiles: [
                      CustomListTile(
                          context, "coolant", "Add Coolant", "/ar/coolant"),
                      CustomListTile(
                          context, "tyre", "Change Tyres", "/ar/change_tyre"),
                      CustomListTile(
                          context, "car_battery", "Jumpstarting", ""),
                      CustomListTile(
                          context, "headlight", "Change Headlights", ""),
                      CustomListTile(
                          context, "windshield", "Replace Wipers", ""),
                    ]).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomListTile(
    BuildContext context, String icon, String text, String path) {
  return Container(
    height: MediaQuery.of(context).size.height / 7,
    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 57),
    child: ListTile(
      onTap: () => navigateToPage(path),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ImageIcon(
            AssetImage("assets/icons/$icon.png"),
            color: Colors.black87,
            size: MediaQuery.of(context).size.height / 15,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 25,
                right: MediaQuery.of(context).size.height / 25),
            child: Text(text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 25,
                )),
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
                () => navigateToPage(path);
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
