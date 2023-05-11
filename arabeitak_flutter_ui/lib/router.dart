import 'package:arabeitak_flutter_ui/presentation/ar_list.dart';
import 'package:arabeitak_flutter_ui/presentation/home_page/home_page.dart';
import 'package:arabeitak_flutter_ui/presentation/introduction_page/introduction_page.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/my_car_page.dart';
import 'package:arabeitak_flutter_ui/presentation/owned_cars.dart';
import 'package:arabeitak_flutter_ui/presentation/procedures_page/maintenance_procedures_page.dart';
import 'package:arabeitak_flutter_ui/presentation/select_car_model_page.dart';
import 'package:arabeitak_flutter_ui/presentation/text_list.dart';
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
          GoRoute(
            path: 'maintenance_procedures_page',
            builder: (BuildContext context, GoRouterState state) {
              return const MaintenaceProceduresPage();
            },
          ),

          // Old paths
          GoRoute(
            path: 'owned_cars',
            builder: (BuildContext context, GoRouterState state) {
              return OwnedCarsPage();
            },
          ),
          GoRoute(
            path: 'select_car_page',
            builder: (BuildContext context, GoRouterState state) {
              return const SelectCarModelPage();
            },
          ),
          GoRoute(
            path: 'text_list',
            builder: (BuildContext context, GoRouterState state) {
              return const TextList();
            },
          ),
          GoRoute(
            path: 'ar_list',
            builder: (BuildContext context, GoRouterState state) {
              return const ARList();
            },
          ),
        ],
      ),
    ],
  );
}
