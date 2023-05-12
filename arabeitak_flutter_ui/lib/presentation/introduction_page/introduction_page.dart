import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

// TODO: use shared_preferences to display the screen only once

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Introduction screen dots decorator 
    DotsDecorator dotsDecorator = DotsDecorator(
      size: const Size.square(10.0),
      activeSize: const Size(40.0, 10.0),
      activeColor: Theme.of(context).primaryColor,
      color: Theme.of(context).disabledColor,
      spacing: const EdgeInsets.symmetric(horizontal: 3.0),
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );

    // Introduction screen pages (text only)
    List<Widget> customPages = [
      customPageView(context, "Welcome to the world of AR car maintenance!"),
      customPageView(context,
          "Our app leverages the latest in AR technology to provide you with a hands-on, interactive experience when it comes to maintaining your vehicle."),
      customPageView(context,
          "From diagnosing issues to finding replacement parts, our app makes it easy to take control of your vehicle\'s health.")
    ];

    // Stack with the car as the background + intro screen as the foreground
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width *0.8, maxHeight: MediaQuery.of(context).size.height *0.85,),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.1),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                    image: AssetImage("assets/images/white_front_corolla_right.png"),
                  ),
                ),
              ),
            ),
          ),
          IntroductionScreen(
            globalBackgroundColor: Colors.transparent,
            rawPages: customPages,
            baseBtnStyle: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Theme.of(context).primaryColor),
            showSkipButton: true,
            skip: const Text("Skip"),
            onSkip: (() {context.go('/home_page');}),
            next: const Icon(Icons.navigate_next),
            done: const Icon(Icons.check),
            onDone: () {context.go('/home_page');},
            dotsDecorator: dotsDecorator,
          ),
        ],
      ),
    );
  }

  Widget customPageView(BuildContext context, String text) {
    List<Text> textWidgets = [
      Text("ARabeitak", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
      Text(text, style: Theme.of(context).textTheme.bodyMedium),
    ];
    // TODO: create space constraints without padding
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 48.0, right: 48.0, top: 100.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: textWidgets,
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: 64.0, right: MediaQuery.of(context).size.width*0.25, top: 24.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: textWidgets,
                ),
              );
      },
    );
  }
}
