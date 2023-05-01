import 'package:flutter/material.dart';
import 'auth/XXlogin.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  // Page 1
                  Container(
                    color: Color.fromARGB(214, 255, 255, 255),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Welcome to the world of AR car maintenance!',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(198, 42, 42, 42)),
                        ),
                      ),
                    ),
                  ),
                  // Page 2
                  Container(
                    color: Color.fromARGB(214, 255, 255, 255),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Our app leverages the latest in AR technology to provide you with a hands-on, interactive experience when it comes to maintaining your vehicle.',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(198, 42, 42, 42)),
                        ),
                      ),
                    ),
                  ),
                  // Page 3
                  Container(
                    color: const Color.fromARGB(214, 255, 255, 255),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'From diagnosing issues to finding replacement parts, our app makes it easy to take control of your vehicle\'s health.',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(198, 42, 42, 42),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(198, 42, 42, 42)),
                          ),
                          onPressed: () {
                            // Jump to home screen
                            Navigator.pushNamed(context, '/auth/login');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < 3; i++)
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: i == _currentPage
                                        ? Color.fromARGB(198, 42, 42, 42)
                                        : Color.fromARGB(198, 42, 42, 42)
                                            .withOpacity(0.4),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        _currentPage == 2
                            ? TextButton(
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 42, 87, 107),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(198, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Jump to home screen
                                      Navigator.pushNamed(
                                          context, '/auth/login');
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  // Jump to home screen
                                  Navigator.pushNamed(context, '/auth/login');
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  // Swipe to next page
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
