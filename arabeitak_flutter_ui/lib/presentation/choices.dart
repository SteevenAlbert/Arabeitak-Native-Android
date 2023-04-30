import 'package:flutter/material.dart';

Color customBlackColor = const Color.fromARGB(255, 53, 53, 53);
Color customWhiteColor = const Color.fromARGB(255, 237, 237, 237);

class ChoicesPage extends StatefulWidget {
  const ChoicesPage({Key? key}) : super(key: key);

  @override
  State<ChoicesPage> createState() => _ChoicesPageState();
}

class _ChoicesPageState extends State<ChoicesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customWhiteColor,
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
            customCardButton(
                context, "augmented_reality", "AR Instructions", "ar_list"),
            const Text("or"),
            customCardButton(context, "text", "Text Instructions", "text_list"),
          ],
        ),
      ),
    );
  }
}

Widget customCardButton(
    BuildContext context, String icon, String text, String? path) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: customWhiteColor,
      boxShadow: const [
        BoxShadow(
          blurRadius: 30,
          offset: Offset(-20, -20),
          color: Colors.grey,
        ),
      ],
    ),
    child: TextButton(
      onPressed: (() {
        Navigator.pushNamed(context, '/$path');
      }),
      style:
          ButtonStyle(shadowColor: MaterialStateProperty.all(Colors.black12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.height / 2.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage("assets/icons/$icon.png"),
                color: Colors.black87,
                size: MediaQuery.of(context).size.height / 7,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
