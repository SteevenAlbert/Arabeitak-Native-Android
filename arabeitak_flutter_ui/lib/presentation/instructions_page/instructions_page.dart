import 'package:arabeitak_flutter_ui/main.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Stack(alignment: Alignment.centerRight, children: [
              Icon(Icons.handyman,
                  color: Theme.of(context).disabledColor.withOpacity(0.03),
                  size: 300),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.end,
                      "Jumpstart a Dead Battery",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigateToPage('/ar/change_tyre');
                      },
                      style: ElevatedButton.styleFrom(
                            side: BorderSide(color:  Theme.of(context).primaryColor),
                            shape: const StadiumBorder()),
                      child: const Text("Open in AR"),
                    )
                  ],
                ),
              ),
            ]),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                child: const Text("1"),
              ),
              title: const Text("Open the hood"),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                child: const Text("2"),
              ),
              title: const Text("Remove the engine cover"),
              subtitle: const Text(
                  "Raise the rear of the engine cover to remove the two rear clips, and then raise the front of the engine cover to remove the two front clips"),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                child: const Text("3"),
              ),
              title: const Text(
                  "Connect the jumper cables according to the following procedure"),
              subtitle: const Text(
                  "Connect a positive jumper cable clamp to the positive (+) battery terminal on your vehicle. \n Connect the clamp on the other end of the positive cable to the positive (+) battery terminal on the second vehicle. \n  Connect a negative cable clamp to the negative (-) battery terminal on the second vehicle. \n Connect the clamp at the other end of the negative cable to a solid, stationary, unpainted metallic point away from the battery and any moving parts, as shown in the illustration."),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                child: const Text("4"),
              ),
              title: const Text(
                  "Start the engine of the second vehicle. Increase the engine speed slightly and maintain at that level for approximately 5 minutes to recharge the battery of your vehicle."),
            )
          ],
        ),
      ),
    );
  }
}
