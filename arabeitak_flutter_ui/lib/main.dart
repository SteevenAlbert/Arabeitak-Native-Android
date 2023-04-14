import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Intro_page.dart';
import 'home_page.dart';

const platform = MethodChannel('flutter.native/helper');
Future<void> navigateToPage(String pageName) async {
  try {
    await platform.invokeMethod('navigateToPage', {'pageName': pageName});
  } on PlatformException catch (e) {
    // Handle exception
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}
