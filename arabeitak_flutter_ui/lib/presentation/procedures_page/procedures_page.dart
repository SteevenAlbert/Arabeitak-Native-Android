import 'package:arabeitak_flutter_ui/presentation/procedures_page/procedures_list.dart';
import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

class ProceduresPage extends StatelessWidget {
  String type;
  ProceduresPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MediaQuery.of(context).orientation == Orientation.portrait
              ? _buildNormalContainer(context)
              : _buildWideContainers(context);
        },
      ),
    );
  }

  Widget _buildWideContainers(context) {
    return Row(
      children: [
        Image(
          image: const AssetImage("assets/images/hologram.png"),
          alignment: Alignment.centerLeft,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 2,
        ),
        ProceduresList(isPortrait: false, type: type),
      ],
    );
  }

  Widget _buildNormalContainer(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage("assets/images/hologram.png"),
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        ProceduresList(isPortrait: true, type: type)
      ],
    );
  }
}