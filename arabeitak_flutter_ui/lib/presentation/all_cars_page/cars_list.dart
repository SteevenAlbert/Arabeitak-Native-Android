import 'package:arabeitak_flutter_ui/domain/models/testing_car.dart';
import 'package:arabeitak_flutter_ui/presentation/all_cars_page/car_card.dart';
import 'package:flutter/material.dart';

class CarsList extends StatelessWidget {
  const CarsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> carCards = [];
    for (TestingCar car in TestingCar.allCars) {
      carCards.add(CarCard(
        car: car,
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: carCards,
      ),
    );
  }
}
