import 'package:arabeitak_flutter_ui/domain/models/testing_car.dart';
import 'package:arabeitak_flutter_ui/presentation/all_cars_page/all_cars_page.dart';
import 'package:arabeitak_flutter_ui/presentation/ar_list.dart';
import 'package:arabeitak_flutter_ui/presentation/chat.dart';
import 'package:arabeitak_flutter_ui/presentation/home_page/home_page.dart';
import 'package:arabeitak_flutter_ui/presentation/instructions_page/instructions_page.dart';
import 'package:arabeitak_flutter_ui/presentation/introduction_page/introduction_page.dart';
import 'package:arabeitak_flutter_ui/presentation/my_car_page/my_car_page.dart';
import 'package:arabeitak_flutter_ui/presentation/owned_cars.dart';
import 'package:arabeitak_flutter_ui/presentation/preview_text_instructions_page.dart';
import 'package:arabeitak_flutter_ui/presentation/procedures_page/procedures_page.dart';
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
              return MyCarPage(car: state.extra as TestingCar);
            },
          ),
          GoRoute(
            path: 'procedures_page/:type',
            name: 'procedures_page',
            builder: (BuildContext context, GoRouterState state) {
              return ProceduresPage(
                type: state.pathParameters['type']!,
              );
            },
          ),
          GoRoute(
            path: 'all_cars_page',
            builder: (BuildContext context, GoRouterState state) {
              return const AllCarsPage();
            },
          ),
          GoRoute(
            path: 'instructions_page',
            builder: (BuildContext context, GoRouterState state) {
              return const InstructionsPage();
            },
          ),
          GoRoute(
            path: 'chat',
            builder: (BuildContext context, GoRouterState state) {
              return const ChatPage();
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
          GoRoute(
            path: 'preview_text_instructions_page',
            builder: (BuildContext context, GoRouterState state) {
              return PreviewTextInstructionsPage();
            },
          ),
        ],
      ),
    ],
  );
}
