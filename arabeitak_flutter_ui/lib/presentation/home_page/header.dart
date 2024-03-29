import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        trailing: CircleAvatar(backgroundColor: Theme.of(context).cardColor,),
        title: Text(
          "Hello Jared,",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
        subtitle: Text(
          "Which car are we treating today?",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
