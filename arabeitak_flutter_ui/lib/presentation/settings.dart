import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void dispose() {
    super.dispose();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //TODO: translation package + UI
            TextButton(
                onPressed: (() {}),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Language",
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
