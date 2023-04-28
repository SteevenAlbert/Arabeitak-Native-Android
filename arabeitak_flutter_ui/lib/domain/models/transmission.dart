enum TransmissionType { manual, automatic, semiAutomatic }

extension TransmissionTypeExtension on TransmissionType {
  Map<String, dynamic> toMap() {
    switch (this) {
      case TransmissionType.manual:
        return {'transmission': 'Manual'};
      case TransmissionType.automatic:
        return {'transmission': 'Automatic'};
      case TransmissionType.semiAutomatic:
        return {'transmission': 'Semi-automatic'};
      default:
        throw Exception('Unknown transmission type');
    }
  }

  static TransmissionType fromMap(String transmission) {
    switch (transmission) {
      case 'Manual':
        return TransmissionType.manual;
      case 'Automatic':
        return TransmissionType.automatic;
      case 'Semi-automatic':
        return TransmissionType.semiAutomatic;
      default:
        throw Exception('Unknown transmission style: $transmission');
    }
  }
}
