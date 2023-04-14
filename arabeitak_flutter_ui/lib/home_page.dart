import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 88.0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Add text welcome Username aligned to the left
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Text(
                'Welcome, Steven',
                style: TextStyle(
                  fontSize: 24,
                  //make it bold
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(198, 42, 42, 42),
                ),
              ),
            ),

            Image.asset(
              'assets/images/corolla.png',
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildFixListItem(context, 'Add Coolant', '/coolant'),
                  _buildFixListItem(context, 'Change Wipers', '/wipers'),
                  _buildFixListItem(context, 'Jumpstart Battery', '/jumpstart'),
                  _buildFixListItem(context, 'Change Tires', '/tires'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixListItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Jump to home screen
        navigateToPage(route);
      },
    );
  }
}
