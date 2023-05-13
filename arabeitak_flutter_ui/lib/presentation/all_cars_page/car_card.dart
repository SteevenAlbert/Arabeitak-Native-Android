import 'package:arabeitak_flutter_ui/domain/models/testing_car.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final TestingCar car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/${car.imagePath}'),
                ),
              ),
            ),
        title: Text(car.model),
        subtitle:Text(car.manufacturer),
      ),
      
    );
  }
}