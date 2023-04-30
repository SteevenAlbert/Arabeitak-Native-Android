import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //TODO: UI
            TextButton(
                onPressed: (() {
                  // Navigator.pushNamed(context, '');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Remote Assistance",
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/owned_cars_page');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Selected Car Model",
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/choices');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Do It Yourself",
                    style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: (() {
                  // Navigator.pushNamed(context, '');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Settings",
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
