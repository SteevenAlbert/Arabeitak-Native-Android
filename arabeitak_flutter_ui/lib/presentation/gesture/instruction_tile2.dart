import 'package:flutter/material.dart';
import "instruction.dart";

class InstructionTile2 extends StatefulWidget {
  final int index;
  const InstructionTile2({super.key, required this.index});

  @override
  State<InstructionTile2> createState() => _InstructionTile2State();
}

class _InstructionTile2State extends State<InstructionTile2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 17,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 12,
            child: Text(
              Instruction.instlist[widget.index].instnum,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        title: Text(Instruction.instlist[widget.index].text),
        // children: [
        //   SizedBox(height: 2),
        //   for (var guidingtext
        //       in Instruction.instlist[index].guidingtext!)
        //     Padding(
        //       padding: const EdgeInsets.all(3.0),
        //       child: ListTile(title: Text(guidingtext)),
        //     )
        // ],
        // subtitle: Text('Item description'),
        // trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
