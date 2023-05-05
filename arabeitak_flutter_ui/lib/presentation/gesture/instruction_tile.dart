import 'package:flutter/material.dart';
import "instruction.dart";

class InstructionTile extends StatelessWidget {
  final int index;
  const InstructionTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        radius: 17,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 12,
          child: Text(
            Instruction.instlist[index].instnum,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      title: Text(Instruction.instlist[index].text),
    );
  }
}
