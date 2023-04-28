// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/body_style.dart';
import 'package:arabeitak_flutter_ui/domain/models/car_model.dart';
import 'package:arabeitak_flutter_ui/domain/models/engine.dart';
import 'package:arabeitak_flutter_ui/domain/models/transmission.dart';

class Car {
  String vin;
  CarModel model;
  String color;
  int mileage;
  String fuelType;
  TransmissionType transmission;
  BodyStyle bodyStyle;
  Engine engine;
  Car({
    required this.vin,
    required this.model,
    required this.color,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
    required this.bodyStyle,
    required this.engine,
  });

  Car copyWith({
    String? vin,
    CarModel? model,
    String? color,
    int? mileage,
    String? fuelType,
    TransmissionType? transmission,
    BodyStyle? bodyStyle,
    Engine? engine,
  }) {
    return Car(
      vin: vin ?? this.vin,
      model: model ?? this.model,
      color: color ?? this.color,
      mileage: mileage ?? this.mileage,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      engine: engine ?? this.engine,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vin': vin,
      'model': model.toMap(),
      'color': color,
      'mileage': mileage,
      'fuelType': fuelType,
      'transmission': transmission.toMap(),
      'bodyStyle': bodyStyle.toMap(),
      'engine': engine.toMap(),
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      vin: map['vin'] as String,
      model: CarModel.fromMap(map['model']),
      color: map['color'] as String,
      mileage: map['mileage'] as int,
      fuelType: map['fuelType'] as String,
      transmission: TransmissionTypeExtension.fromMap(map['transmission']),
      bodyStyle: BodyStyleExtension.fromMap(map['bodyStyle']),
      engine: Engine.fromMap(map['engine'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Car(vin: $vin,model: $model, color: $color, mileage: $mileage, fuelType: $fuelType, transmission: $transmission, bodyStyle: $bodyStyle, engine: $engine)';
  }

  @override
  bool operator ==(covariant Car other) {
    if (identical(this, other)) return true;

    return other.vin == vin &&
        other.model == model &&
        other.color == color &&
        other.mileage == mileage &&
        other.fuelType == fuelType &&
        other.transmission == transmission &&
        other.bodyStyle == bodyStyle &&
        other.engine == engine;
  }

  @override
  int get hashCode {
    return vin.hashCode ^
        model.hashCode ^
        color.hashCode ^
        mileage.hashCode ^
        fuelType.hashCode ^
        transmission.hashCode ^
        bodyStyle.hashCode ^
        engine.hashCode;
  }
}
