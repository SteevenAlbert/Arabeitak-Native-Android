import 'package:arabeitak_flutter_ui/presentation/my_car_page/action_card.dart';
import 'package:flutter/material.dart';

class ActionsGrid extends StatelessWidget {
  const ActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    const double itemHeight = 200;
    final double itemWidth = size.width * 0.5;

    List<Widget> actionsWidgets = initActionsWidgets();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        childAspectRatio: itemWidth / itemHeight,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2.toInt(),
        children: actionsWidgets,
      ),
    );
  }

  List<Widget> initActionsWidgets() {
    List<List> actions = [
      [
        '/maintenance_procedures_page',
        "Maintenance Procedures",
        "Keep it moving",
        Icons.handyman,
        true
      ],
      [
        '/maintenance_procedures_page',
        "More about my car",
        "Unleash your car's full potential",
        Icons.info,
        true
      ],
      ['/', "Remote Assistance", "Call a specialist", Icons.video_call, false],
      [
        '/chat',
        "Can't find your question?",
        "Chat with our AI bot",
        Icons.chat_bubble_rounded,
        true
      ],
    ];

    List<Widget> widgets = [];

    for (List item in actions) {
      widgets.add(ActionCard(
        path: item[0],
        title: item[1],
        subtitle: item[2],
        iconData: item[3],
        isFlutterPath: item[4],
      ));
    }
    return widgets;
  }
}
