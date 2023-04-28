// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Engine {
  String engineType;
  int engineSize;
  int horsepower;
  int torque;
  Engine({
    required this.engineType,
    required this.engineSize,
    required this.horsepower,
    required this.torque,
  });

  Engine copyWith({
    String? engineType,
    int? engineSize,
    int? horsepower,
    int? torque,
  }) {
    return Engine(
      engineType: engineType ?? this.engineType,
      engineSize: engineSize ?? this.engineSize,
      horsepower: horsepower ?? this.horsepower,
      torque: torque ?? this.torque,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'engineType': engineType,
      'engineSize': engineSize,
      'horsepower': horsepower,
      'torque': torque,
    };
  }

  factory Engine.fromMap(Map<String, dynamic> map) {
    return Engine(
      engineType: map['engineType'] as String,
      engineSize: map['engineSize'] as int,
      horsepower: map['horsepower'] as int,
      torque: map['torque'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Engine.fromJson(String source) =>
      Engine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Engine(engineType: $engineType, engineSize: $engineSize, horsepower: $horsepower, torque: $torque)';
  }

  @override
  bool operator ==(covariant Engine other) {
    if (identical(this, other)) return true;

    return other.engineType == engineType &&
        other.engineSize == engineSize &&
        other.horsepower == horsepower &&
        other.torque == torque;
  }

  @override
  int get hashCode {
    return engineType.hashCode ^
        engineSize.hashCode ^
        horsepower.hashCode ^
        torque.hashCode;
  }
}
