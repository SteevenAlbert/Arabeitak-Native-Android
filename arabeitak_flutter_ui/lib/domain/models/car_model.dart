// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/manufacturer.dart';

class CarModel {
  // car model class not the car class includes make attribute so that we can relate it to specifc procedures that are related to a specifc car
  String cid;
  Manufacturer make;
  String model;
  int year;
  CarModel({
    required this.cid,
    required this.make,
    required this.model,
    required this.year,
  });

  CarModel copyWith({
    String? cid,
    Manufacturer? make,
    String? model,
    int? year,
  }) {
    return CarModel(
      cid: cid ?? this.cid,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'make': make.toMap(),
      'model': model,
      'year': year,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      cid: map['cid'] as String,
      make: Manufacturer.fromMap(map['make'] as Map<String, dynamic>),
      model: map['model'] as String,
      year: map['year'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarModel(cid: $cid, make: $make, model: $model, year: $year)';
  }

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;

    return other.cid == cid &&
        other.make == make &&
        other.model == model &&
        other.year == year;
  }

  @override
  int get hashCode {
    return cid.hashCode ^ make.hashCode ^ model.hashCode ^ year.hashCode;
  }
}
