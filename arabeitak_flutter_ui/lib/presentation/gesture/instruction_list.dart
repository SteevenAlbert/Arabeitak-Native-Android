import 'package:flutter/material.dart';
import "instruction.dart";
import 'instruction_tile.dart';
import 'instruction_tile2.dart';
import 'badge.dart';

class InstructionList extends StatefulWidget {
  const InstructionList({super.key});

  @override
  State<InstructionList> createState() => _InstructionTileState();
}

class _InstructionTileState extends State<InstructionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: Instruction.instlist.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Instruction.instlist[index].trigger == null
                    ? (Instruction.instlist[index].guidingtext == null
                        ? InstructionTile(index: index)
                        : InstructionTile2(index: index))
                    : BadgeTrig(
                        trigger: Instruction.instlist[index].trigger!,
                        widget: Instruction.instlist[index].guidingtext == null
                            ? InstructionTile(index: index)
                            : InstructionTile2(index: index))),
          );
        },
      ),
    );
  }
}
