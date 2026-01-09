import 'package:arabeitak_flutter_ui/domain/models/testing_procedure.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomListTile extends StatelessWidget {
  final TestingProcedure procedure;
  const CustomListTile({super.key, required this.procedure});

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: const Text('Not implemented yet, come again soon!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    return ListTile(
      onTap: () => procedure.steps.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(snackBar)
          : context.push('/instructions_page', extra: procedure),
      leading: ImageIcon(
        AssetImage("assets/icons/${procedure.iconPath}"),
      ),
      title: Text(procedure.title),
      trailing: const Icon(
        Icons.navigate_next_sharp,
      ),
    );
  }
}
