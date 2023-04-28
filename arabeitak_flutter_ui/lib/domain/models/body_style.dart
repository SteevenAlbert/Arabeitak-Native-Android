enum BodyStyle { sedan, coupe, hatchback, suv, truck, van }

extension BodyStyleExtension on BodyStyle {
  Map<String, dynamic> toMap() {
    switch (this) {
      case BodyStyle.sedan:
        return {'name': 'Sedan'};
      case BodyStyle.coupe:
        return {'name': 'Coupe'};
      case BodyStyle.hatchback:
        return {'name': 'Hatchback'};
      case BodyStyle.suv:
        return {'name': 'SUV'};
      case BodyStyle.truck:
        return {'name': 'Truck'};
      case BodyStyle.van:
        return {'name': 'Van'};
      default:
        throw Exception('Unknown body style');
    }
  }

  static BodyStyle fromMap(String name) {
    switch (name) {
      case 'Sedan':
        return BodyStyle.sedan;
      case 'Coupe':
        return BodyStyle.coupe;
      case 'Hatchback':
        return BodyStyle.hatchback;
      case 'SUV':
        return BodyStyle.suv;
      case 'Truck':
        return BodyStyle.truck;
      case 'Van':
        return BodyStyle.van;
      default:
        throw Exception('Unknown body style: $name');
    }
  }
}
