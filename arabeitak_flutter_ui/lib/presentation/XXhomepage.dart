import 'package:flutter/material.dart';
import '/main.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 88.0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Add text welcome Username aligned to the left
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                child: Text(
                  'Welcome, Steven',
                  style: TextStyle(
                    fontSize: 24,
                    //make it bold
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(198, 42, 42, 42),
                  ),
                ),
              ),

              Image.asset(
                'assets/images/corolla.png',
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildFixListItem(
                        context, 'Add Coolant', '/check_your_coolant'),
                    _buildFixListItem(context, 'Change Wipers',
                        '/change_your_windshield_wiper_blades'),
                    _buildFixListItem(context, 'Jumpstart Battery',
                        '/jumpstart_a_dead_battery'),
                    _buildFixListItem(
                        context, 'Change Tires', '/change_flat_tire'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFixListItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        // Jump to home screen
        navigateToPage(route);
      },
    );
  }
}
