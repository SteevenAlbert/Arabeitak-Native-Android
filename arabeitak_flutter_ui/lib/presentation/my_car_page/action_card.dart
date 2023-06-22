import 'package:arabeitak_flutter_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionCard extends StatelessWidget {
  final IconData iconData;
  final String title, subtitle, path;
  final bool isFlutterPath;
  Map<String, String>? pathParams;

  ActionCard(
      {required this.path,
      this.pathParams,
      required this.title,
      required this.subtitle,
      required this.iconData,
      required this.isFlutterPath,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pathParams == null
            ? isFlutterPath
                ? context.push(path)
                : navigateToPage(path)
            : context.push('$path/${pathParams!['type']}');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(iconData),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
