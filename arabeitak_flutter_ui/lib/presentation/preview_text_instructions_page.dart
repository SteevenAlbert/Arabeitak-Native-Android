import 'package:flutter/material.dart';
import 'package:arabeitak_flutter_ui/repositories/gpt.dart';
// import 'package:flutter/services.dart';
// import 'package:starflut/starflut.dart';

class PreviewTextInstructionsPage extends StatelessWidget {
  PreviewTextInstructionsPage({super.key});

  //TODO: pass car model and procedure name from prev screen
  final Future inst = GPT.run("2016 toyota corolla", "change tyre");

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
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 15,
            ),
            child: Align(
                child: FutureBuilder(
              future: inst,
              builder: (BuildContext context, AsyncSnapshot inst) {
                if (inst.hasData) {
                  // return Text(inst.data.toString());
                  return ListView.builder(
                      itemCount: inst.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return customListTile(context, (index + 1).toString(),
                            inst.data[index].substring(2));
                      });
                } else {
                  return const Text('Loading...');
                }
              },
            ))),
      ),
    );
  }
}

Widget customListTile(BuildContext context, String icon, String text) {
  return Container(
    height: MediaQuery.of(context).size.height / 7,
    padding: EdgeInsets.all(MediaQuery.of(context).size.height / 57),
    child: ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            for (var i = 0; i < icon.length; i++)
              ImageIcon(
                AssetImage("icons/numbers/${icon[i]}.png"),
                color: Colors.black87,
                size: MediaQuery.of(context).size.height / 15,
              ),
          ]),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 25,
                  right: MediaQuery.of(context).size.height / 25),
              child: Text(text,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 25,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
