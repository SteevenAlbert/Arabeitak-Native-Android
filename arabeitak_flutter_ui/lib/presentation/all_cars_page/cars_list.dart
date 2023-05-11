import 'package:arabeitak_flutter_ui/presentation/all_cars_page/car_card.dart';
import 'package:flutter/material.dart';

class CarsList extends StatelessWidget {
  const CarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: const [
          CarCard(carManufacturer: 'Toyota', carModel: 'Corolla 2020', imagePath: 'assets/images/sketch.png',),
          CarCard(carManufacturer: 'Toyota', carModel: 'Yaris 2015', imagePath: 'assets/images/sketch.png',),
        ],
      ),
    );
  }
}