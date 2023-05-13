import 'package:arabeitak_flutter_ui/domain/models/testing_car.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/actions_grid.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/car_header.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCarPage extends StatelessWidget {
  final TestingCar car;
  const MyCarPage({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: SafeArea(
        child: ListView(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image(
                  image: AssetImage("assets/images/${car.imagePath}"),
                ),
              ),
            ),
            CarHeader(
              car: car,
            ),
            const ActionsGrid()
          ],
        ),
      ),
    );
  }
}
