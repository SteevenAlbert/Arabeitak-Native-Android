import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class BadgeTrig extends StatelessWidget {
  final Widget widget;
  final int trigger;
  const BadgeTrig({super.key, required this.widget, required this.trigger});

  @override
  Widget build(BuildContext context) {
    return Badge(
        badgeContent:
            trigger == 1 ? const Text('Danger') : const Text('Warning'),
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(8),
        badgeColor: trigger == 1 ? Colors.red : Colors.yellow,
        position: const BadgePosition(start: -15, top: -12),
        child: widget);
  }
}
