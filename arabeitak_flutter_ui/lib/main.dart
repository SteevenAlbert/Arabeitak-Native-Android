import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:firebase_core/firebase_core.dart';
// import 'presentation/Intro_page.dart';
import 'presentation/introduction_page.dart';
// import 'presentation/auth/login.dart';
import 'presentation/auth/log_in.dart';
import 'presentation/auth/sign_up.dart';
// import 'presentation/homepage.dart';
import 'presentation/home_page.dart';
import 'presentation/owned_cars.dart';
import 'presentation/select_car_model_page.dart';
import 'presentation/choices.dart';
import 'presentation/ar_list.dart';
import 'presentation/text_list.dart';
import 'presentation/preview_text_instructions_page.dart';
import 'presentation/settings.dart';

const platform = MethodChannel('flutter.native/helper');
Future<void> navigateToPage(String pageName) async {
  try {
    await platform.invokeMethod('navigateToPage', {'pageName': pageName});
  } on PlatformException catch (e) {
    // Handle exception
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/auth/log_in': (context) => LogInPage(),
        '/auth/sign_up': (context) => SignUpPage(),
        '/home': (context) => const HomePage(),
        '/owned_cars_page': (context) => OwnedCarsPage(),
        '/select_car_page': (context) => SelectCarModelPage(),
        '/choices': (context) => ChoicesPage(),
        '/ar_list': (context) => const ARList(),
        '/text_list': (context) => const TextList(),
        '/preview_text_instructions_page': (context) =>
            PreviewTextInstructionsPage(),
        'settings': ((context) => SettingPage())
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      home: const IntroPage(),
    );
  }
}
