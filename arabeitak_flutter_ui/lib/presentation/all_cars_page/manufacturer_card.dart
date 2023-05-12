import 'package:flutter/material.dart';

class ManufacturerCard extends StatelessWidget {

  final String imagePath, title;

  const ManufacturerCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
