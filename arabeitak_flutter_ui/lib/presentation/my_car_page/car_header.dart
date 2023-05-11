import 'package:flutter/material.dart';

class CarHeader extends StatelessWidget {
  const CarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Corolleti",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left,
          ),
          Text(
            'Toyota Corolla 2020',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
