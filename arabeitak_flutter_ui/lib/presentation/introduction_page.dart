import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      rawPages: [
        CustomPageView(context, "Welcome to the world of AR car maintenance!"),
        CustomPageView(context,
            "Our app leverages the latest in AR technology to provide you with a hands-on, interactive experience when it comes to maintaining your vehicle."),
        CustomPageView(context,
            "From diagnosing issues to finding replacement parts, our app makes it easy to take control of your vehicle\'s health.")
      ],
      baseBtnStyle: TextButton.styleFrom(
          backgroundColor: Colors.transparent, foregroundColor: Colors.black87),
      showSkipButton: true,
      skip: const Text("Skip"),
      onSkip: (() {
        Navigator.pushNamed(context, '/auth/log_in');
        // Navigator.pushNamed(context, '/home');
      }),
      next: const Icon(Icons.navigate_next),
      done: const Icon(Icons.check),
      onDone: () {
        Navigator.pushNamed(context, '/auth/log_in');
        // Navigator.pushNamed(context, '/home');
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(40.0, 10.0),
        activeColor: Colors.black87,
        color: Colors.grey.shade300,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget CustomPageView(BuildContext context, String text) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: const AssetImage("assets/images/car_left.png"),
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height,
          ),
          FittedBox(
            // padding: const EdgeInsets.all(11.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ARabeitak",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 21,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(text,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 27,
                        )),
                  ]),
            ),
          ),
          Image(
            image: const AssetImage("assets/images/car_right.png"),
            alignment: Alignment.centerRight,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
}
