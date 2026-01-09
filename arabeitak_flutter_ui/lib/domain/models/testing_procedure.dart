// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/testing_instruction.dart';
import 'package:collection/collection.dart';

class TestingProcedure {
  String title;
  String iconPath;
  List<TestingInstruction> steps;
  TestingProcedure({
    required this.title,
    required this.iconPath,
    required this.steps,
  });

  TestingProcedure copyWith({
    String? title,
    String? iconPath,
    List<TestingInstruction>? steps,
  }) {
    return TestingProcedure(
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'iconPath': iconPath,
      'steps': steps.map((x) => x.toMap()).toList(),
    };
  }

  factory TestingProcedure.fromMap(Map<String, dynamic> map) {
    return TestingProcedure(
      title: map['title'] as String,
      iconPath: map['iconPath'] as String,
      steps: List<TestingInstruction>.from(
        (map['steps'] as List<int>).map<TestingInstruction>(
          (x) => TestingInstruction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TestingProcedure.fromJson(String source) =>
      TestingProcedure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TestingProcedure(title: $title, iconPath: $iconPath, steps: $steps)';

  @override
  bool operator ==(covariant TestingProcedure other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.title == title &&
        other.iconPath == iconPath &&
        listEquals(other.steps, steps);
  }

  @override
  int get hashCode => title.hashCode ^ iconPath.hashCode ^ steps.hashCode;

  static Map<String, List<TestingProcedure>> maintenanceList = {
    "Get Started": [
      TestingProcedure(
          title: "Find Vehicle Identification Number (VIN)",
          iconPath: "Find Vehicle Identification Number (VIN).png",
          steps: []),
      TestingProcedure(
          title: "Open Car Hood", iconPath: "Open Car Hood.png", steps: []),
    ],
    "Maintenance": [
      TestingProcedure(
        title: "Add Coolant",
        iconPath: "Check Your Coolant.png",
        steps: [
          TestingInstruction(
            type: TestingType.danger,
            title: "Check if the engine is hot",
            text:
                "Do not remove the engine coolant reservoir cap or the radiator cap. The cooling system may be under pressure and may spray hot coolant if the cap is removed, causing serious injuries, such as burns",
          ),
          TestingInstruction(
            type: TestingType.standard,
            title: "Add Coolant",
            text:
                "The coolant level is satisfactory if it is between the “F” and “L” lines on the reservoir when the engine is cold. If the level is on or below the “L” line, add coolant up to the “F” line.",
          ),
          TestingInstruction(
            type: TestingType.warning,
            title: "When adding coolant",
            text:
                "Coolant is neither plain water nor straight antifreeze. The correct mixture of water and antifreeze must be used to provide proper lubrication, corrosion protection and cooling. Be sure to read the antifreeze or coolant label.",
          ),
          TestingInstruction(
            type: TestingType.warning,
            title: "If you spill coolant",
            text:
                "Be sure to wash it off with water to prevent it from damaging parts or paint.",
          ),
        ],
      ),
      TestingProcedure(
        title: "Jumpstart a Dead Battery",
        iconPath: "Open Car Hood.png",
        steps: [
          TestingInstruction(
            type: TestingType.standard,
            title: "Open the hood",
            text: "",
          ),
          TestingInstruction(
              type: TestingType.standard,
              title: "Remove the engine cover",
              text:
                  "Raise the rear of the engine cover to remove the two rear clips, and then raise the front of the engine cover to remove the two front clips"),
          TestingInstruction(
            type: TestingType.standard,
            title:
                "Connect the jumper cables according to the following procedure",
            text:
                "Connect a positive jumper cable clamp to the positive (+) battery terminal on your vehicle. \n Connect the clamp on the other end of the positive cable to the positive (+) battery terminal on the second vehicle. \n  Connect a negative cable clamp to the negative (-) battery terminal on the second vehicle. \n Connect the clamp at the other end of the negative cable to a solid, stationary, unpainted metallic point away from the battery and any moving parts, as shown in the illustration.",
          ),
          TestingInstruction(
              type: TestingType.standard,
              title:
                  "Start the engine of the second vehicle. Increase the engine speed slightly and maintain at that level for approximately 5 minutes to recharge the battery of your vehicle.",
              text: ""),
        ],
      ),
      TestingProcedure(
          title: "Change Flat Tire",
          iconPath: "Change Flat Tire.png",
          steps: []),
      TestingProcedure(
          title: "Change Light Bulbs of Front Turn Signal  Parking Lights",
          iconPath:
              "Change Light Bulbs of Front Turn Signal  Parking Lights.png",
          steps: []),
      TestingProcedure(
          title: "Change Your Windshield Wiper Blades",
          iconPath: "Change Your Windshield Wiper Blades.png",
          steps: []),
      TestingProcedure(
          title: "Replace The Air Conditioning Filter",
          iconPath: "Replace The Air Conditioning Filter.png",
          steps: []),
    ]
  };

  static Map<String, List<TestingProcedure>> featuresList = {
    "Get Familiar": [
      TestingProcedure(
          title: "Find Vehicle Identification Number (VIN)",
          iconPath: "Find Vehicle Identification Number (VIN).png",
          steps: []),
      TestingProcedure(
          title: "Open Car Hood", iconPath: "Open Car Hood.png", steps: []),
      TestingProcedure(
          title: "Replace The Electronic Key Battery",
          iconPath: "Replace The Electronic Key Battery.png",
          steps: []),
      TestingProcedure(
          title: "Open or Tilt Moonroof",
          iconPath: "Open or Tilt Moonroof.png",
          steps: []),
    ]
  };
}
