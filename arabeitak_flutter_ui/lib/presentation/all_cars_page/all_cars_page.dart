import 'package:arabeitak_flutter_ui/presentation/all_cars_page/cars_list.dart';
import 'package:arabeitak_flutter_ui/presentation/all_cars_page/manufacturers_horizontal_list.dart';
import 'package:arabeitak_flutter_ui/presentation/all_cars_page/search_bar.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class AllCarsPage extends StatelessWidget {
  const AllCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Browse cars",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SearchBar(),
              const ManufacturersHorizontalList(),
              const CarsList(),
            ],
          ),
        ),
      ),
    );
  }
}
