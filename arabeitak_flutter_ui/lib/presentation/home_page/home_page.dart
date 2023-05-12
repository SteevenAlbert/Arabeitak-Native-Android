import 'package:arabeitak_flutter_ui/presentation/home_page/car_card.dart';
import 'package:arabeitak_flutter_ui/presentation/home_page/header.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SwiperPagination swiperPagination = SwiperPagination(
        builder: DotSwiperPaginationBuilder(
            color: Theme.of(context).disabledColor,
            activeColor: Theme.of(context).primaryColor,
            activeSize: 12,
            space: 4));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/all_cars_page');
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Header(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Swiper(
                viewportFraction: 0.8,
                scale: 0.9,
                itemCount: 3,
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height,
                layout: SwiperLayout.DEFAULT,
                pagination: swiperPagination,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      CarCard(
                        name: "$index",
                      ),
                      addCarImage(context),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addCarImage(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.network(
              "https://s3.us-east-2.amazonaws.com/dealer-inspire-vps-vehicle-images/stock-images/chrome/30021bfe494c70240ab3419f034de887.png"),
        ),
      ),
    );
  }
}
