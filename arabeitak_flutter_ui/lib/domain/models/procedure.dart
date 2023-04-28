// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/car_model.dart';
import 'package:arabeitak_flutter_ui/domain/models/instruction.dart';
import 'package:arabeitak_flutter_ui/domain/models/tool.dart';
import 'package:collection/collection.dart';

class Procedure {
  String pid;
  String name;
  CarModel car;
  List<Tool> tools;
  List<Instruction> instructions;
  Procedure({
    required this.pid,
    required this.name,
    required this.car,
    required this.tools,
    required this.instructions,
  });

  Procedure copyWith({
    String? pid,
    String? name,
    CarModel? car,
    List<Tool>? tools,
    List<Instruction>? instructions,
  }) {
    return Procedure(
      pid: pid ?? this.pid,
      name: name ?? this.name,
      car: car ?? this.car,
      tools: tools ?? this.tools,
      instructions: instructions ?? this.instructions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'name': name,
      'car': car.toMap(),
      'tools': tools.map((x) => x.toMap()).toList(),
      'steps': instructions.map((x) => x.toMap()).toList(),
    };
  }

  factory Procedure.fromMap(Map<String, dynamic> map) {
    return Procedure(
      pid: map['pid'] as String,
      name: map['name'] as String,
      car: CarModel.fromMap(map['car'] as Map<String, dynamic>),
      tools: List<Tool>.from(
        (map['tools'] as List<int>).map<Tool>(
          (x) => Tool.fromMap(x as Map<String, dynamic>),
        ),
      ),
      instructions: List<Instruction>.from(
        (map['steps'] as List<int>).map<Instruction>(
          (x) => Instruction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Procedure.fromJson(String source) =>
      Procedure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Procedure(pid: $pid, name: $name, car: $car, tools: $tools, instructions: $instructions)';
  }

  @override
  bool operator ==(covariant Procedure other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.pid == pid &&
        other.name == name &&
        other.car == car &&
        listEquals(other.tools, tools) &&
        listEquals(other.instructions, instructions);
  }

  @override
  int get hashCode {
    return pid.hashCode ^
        name.hashCode ^
        car.hashCode ^
        tools.hashCode ^
        instructions.hashCode;
  }
}
