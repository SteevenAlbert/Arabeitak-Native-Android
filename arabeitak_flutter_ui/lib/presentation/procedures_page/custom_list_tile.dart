import 'package:arabeitak_flutter_ui/main.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String text, icon, path;
  const CustomListTile(
      {super.key, required this.icon, required this.text, required this.path});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => navigateToPage(path),
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
