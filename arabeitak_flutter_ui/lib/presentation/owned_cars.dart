import 'package:flutter/material.dart';

class OwnedCarsPage extends StatefulWidget {
  @override
  _OwnedCarsPageState createState() => _OwnedCarsPageState();
}

class _OwnedCarsPageState extends State<OwnedCarsPage> {
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
            //TODO:  UI + listing user cars (as well as select and delete option)
            TextButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/select_car_page');
                }),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black12)),
                child: const Text("Add Car",
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
