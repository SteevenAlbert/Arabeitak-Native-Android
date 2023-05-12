import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomListTile extends StatelessWidget {
  final String text, icon, path;
  const CustomListTile(
      {super.key, required this.icon, required this.text, required this.path});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.go('/instructions_page'),
      leading: ImageIcon(
        AssetImage("assets/icons/$icon.png"),
      ),
      title: Text(text),
      trailing: const Icon(
        Icons.navigate_next_sharp,
      ),
    );
  }
}
