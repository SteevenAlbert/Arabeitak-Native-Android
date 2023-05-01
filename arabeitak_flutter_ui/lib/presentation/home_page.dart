import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

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
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Welcome",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //TODO: UI
                    customButton(context, 'remote_assistance',
                        "Remote Assistance", null),

                    customButton(
                        context, 'maintainance', "Do It Yourself", '/choices'),
                    // customButton(context, 'select_car', "Selected Car Model",
                    //     '/owned_cars_page'),
                    customButton(context, 'settings', "Settings", '/settings'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget customButton(
    BuildContext context, String icon, String text, String? path) {
  return GestureDetector(
      child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(10, 10),
                color: Colors.black,
              ),
            ],
            borderRadius: BorderRadius.circular(50),
            color: Colors.transparent,
            // color: Colors.black,
            image: const DecorationImage(
              image: AssetImage("assets/images/bg/option4.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage("assets/icons/$icon.png"),
                  color: Colors.white,
                  // color: Colors.black,
                  size: MediaQuery.of(context).size.height / 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(text,
                      style: const TextStyle(
                        color: Colors.white,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          )),
      onTap: () {
        if (path != null) {
          Navigator.pushNamed(context, path);
        }
      });
}
