import 'package:arabeitak_flutter_ui/domain/models/testing_car.dart';
import 'package:flutter/material.dart';

class CarHeader extends StatelessWidget {
  final TestingCar car;
  const CarHeader({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car.name??"",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left,
          ),
          Text(
            car.model,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
