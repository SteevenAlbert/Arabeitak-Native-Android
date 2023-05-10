import 'package:arabeitak_flutter_ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: [
        'en',
        'ar',
      ]);

  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp.router(
          routerConfig: MyRouter.router,
          title: 'ARabeitak',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: const Color(0xFF111111)),
            fontFamily: GoogleFonts.openSans(
              fontSize: 15,
            ).fontFamily,
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
        ));
  }
}
