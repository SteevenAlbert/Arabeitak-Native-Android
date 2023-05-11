import 'package:arabeitak_flutter_ui/presentation/home_page/home_page.dart';
import 'package:arabeitak_flutter_ui/presentation/introduction_page/introduction_page.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/my_car_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const IntroductionPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'home_page',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: 'my_car_page',
            builder: (BuildContext context, GoRouterState state) {
              return const MyCarPage();
            },
          ),
        ],
      ),
    ],
  );
}
