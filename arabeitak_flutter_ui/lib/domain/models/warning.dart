// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/warning_type.dart';

class Warning {
  String id;
  WarningType type;
  String desc;
  Warning({
    required this.id,
    required this.desc,
    required this.type,
  });

  Warning copyWith({
    String? id,
    WarningType? type,
    String? desc,
  }) {
    return Warning(
        id: id ?? this.id, type: type ?? this.type, desc: desc ?? this.desc);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'type': type.toMap(), 'desc': desc};
  }

  factory Warning.fromMap(Map<String, dynamic> map) {
    return Warning(
      id: map['id'] as String,
      type: WarningTypeExtension.fromMap(map['type']),
      desc: map['desc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Warning.fromJson(String source) =>
      Warning.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Warning(id: $id, type: $type, desc: $desc)';

  @override
  bool operator ==(covariant Warning other) {
    if (identical(this, other)) return true;

    return other.id == id && other.type == type && other.desc == desc;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ desc.hashCode;
}
