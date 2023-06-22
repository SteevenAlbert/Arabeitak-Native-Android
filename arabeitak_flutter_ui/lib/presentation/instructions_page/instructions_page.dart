import 'package:arabeitak_flutter_ui/domain/models/testing_instruction.dart';
import 'package:arabeitak_flutter_ui/domain/models/testing_procedure.dart';
import 'package:arabeitak_flutter_ui/main.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  TestingProcedure procedure;
  InstructionsPage({super.key, required this.procedure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
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
                        procedure.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateToPage(procedure.title);
                        },
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                            shape: const StadiumBorder()),
                        child: const Text("Open in AR"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: procedure.steps.length,
              itemBuilder: (BuildContext context, int index) {
                TestingInstruction instruction = procedure.steps[index];
                switch (instruction.type) {
                  case TestingType.standard:
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).cardTheme.color,
                        foregroundColor: Colors.grey[500],
                        child: Text("${index + 1}"),
                      ),
                      title: Text(instruction.title),
                      subtitle: Text(instruction.text),
                    );

                  case TestingType.warning:
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber[50],
                        foregroundColor: Colors.amber[400],
                        child: const Icon(Icons.warning),
                      ),
                      title: Text(instruction.title),
                      subtitle: Text(instruction.text),
                    );

                  case TestingType.danger:
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red[400],
                        child: const Icon(Icons.dangerous),
                      ),
                      title: Text(instruction.title),
                      subtitle: Text(instruction.text),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
