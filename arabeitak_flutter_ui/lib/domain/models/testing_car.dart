// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestingCar {
 String? name;
  String model;
  String manufacturer;
  String imagePath;
  TestingCar({
    this.name,
    required this.model,
    required this.manufacturer,
    required this.imagePath,
  });
  



  TestingCar copyWith({
    String? name,
    String? model,
    String? manufacturer,
    String? imagePath,
  }) {
    return TestingCar(
      name: name ?? this.name,
      model: model ?? this.model,
      manufacturer: manufacturer ?? this.manufacturer,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'model': model,
      'manufacturer': manufacturer,
      'imagePath': imagePath,
    };
  }

  factory TestingCar.fromMap(Map<String, dynamic> map) {
    return TestingCar(
      name: map['name'] != null ? map['name'] as String : null,
      model: map['model'] as String,
      manufacturer: map['manufacturer'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestingCar.fromJson(String source) => TestingCar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TestingCar(name: $name, model: $model, manufacturer: $manufacturer, imagePath: $imagePath)';
  }

  @override
  bool operator ==(covariant TestingCar other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.model == model &&
      other.manufacturer == manufacturer &&
      other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      model.hashCode ^
      manufacturer.hashCode ^
      imagePath.hashCode;
  }

  static List<TestingCar> myCars =[
    TestingCar(name: "Corolleti", model: "Corolla 2020", manufacturer: "Toyota", imagePath: "corolla.png"),
    TestingCar(name: "Mom's", model: "Elantra 2022", manufacturer: "Hyundai", imagePath: "elantra.png"),
    TestingCar(name: "Work car", model: "C180 2006", manufacturer: "Mercedes", imagePath: "mercedes.png"),
  ];

  static List<TestingCar> allCars = [
    TestingCar(model: "Corolla 2020", manufacturer: "Toyota", imagePath: "corolla.png"),
    TestingCar(model: "Elantra 2022", manufacturer: "Hyundai", imagePath: "elantra.png"),
    TestingCar(model: "C180 2006", manufacturer: "Mercedes", imagePath: "mercedes.png"),
    TestingCar(model: "Sunny 2022", manufacturer: "Nissan", imagePath: "sunny.png"),
  ];

}