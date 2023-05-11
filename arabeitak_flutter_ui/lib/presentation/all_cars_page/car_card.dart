import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String imagePath, carModel, carManufacturer;

  const CarCard({super.key, required this.imagePath, required this.carModel, required this.carManufacturer});

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
                  image: AssetImage(imagePath),
                ),
              ),
            ),
        title: Text(carModel),
        subtitle:Text(carManufacturer),
      ),
      
    );
  }
}