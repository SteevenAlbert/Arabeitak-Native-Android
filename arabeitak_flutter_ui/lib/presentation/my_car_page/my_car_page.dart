import 'package:arabeitak_flutter_ui/presentation/my_car_page/actions_grid.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/car_header.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCarPage extends StatelessWidget {
  const MyCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: SafeArea(
        child: ListView(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.3),
              child: Image.network(
                  fit: BoxFit.contain,
                  "https://s3.us-east-2.amazonaws.com/dealer-inspire-vps-vehicle-images/stock-images/chrome/30021bfe494c70240ab3419f034de887.png"),
            ),
            const CarHeader(),
            const ActionsGrid()
          ],
        ),
      ),
    );
  }
}
