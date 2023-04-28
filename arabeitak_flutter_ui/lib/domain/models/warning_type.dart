//informational --> general info
//cautionary --> potential problem
//warning --> serious problem (imediate attention)
enum WarningType { informational, cautionary, warning }

extension WarningTypeExtension on WarningType {
  Map<String, dynamic> toMap() {
    switch (this) {
      case WarningType.informational:
        return {'type': 'Informational'};
      case WarningType.cautionary:
        return {'type': 'Cautionary'};
      case WarningType.warning:
        return {'type': 'Warning'};
      default:
        throw Exception('Unknown warning type');
    }
  }

  static WarningType fromMap(String type) {
    switch (type) {
      case 'Informational':
        return WarningType.informational;
      case 'Cautionary':
        return WarningType.cautionary;
      case 'Warning':
        return WarningType.warning;
      default:
        throw Exception('Unknown body style: $type');
    }
  }
}
