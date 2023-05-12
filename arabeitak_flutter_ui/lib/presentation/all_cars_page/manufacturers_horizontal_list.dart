import 'package:arabeitak_flutter_ui/presentation/all_cars_page/manufacturer_card.dart';
import 'package:flutter/material.dart';

class ManufacturersHorizontalList extends StatelessWidget {
  const ManufacturersHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        children: const [
          ManufacturerCard(title: "Toyota", imagePath: "assets/images/toyota_logo.png",),
          ManufacturerCard(title: "BMW", imagePath: "assets/images/bmw_logo.png",),
          ManufacturerCard(title: "Nissan", imagePath: "assets/images/nissan_logo.png",),
          ManufacturerCard(title: "Hyundai", imagePath: "assets/images/hyundai_logo.png",),
        ],
      ),
    );
  }
}
