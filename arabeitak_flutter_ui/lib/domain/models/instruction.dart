// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:arabeitak_flutter_ui/domain/models/3d_model.dart';
import 'package:arabeitak_flutter_ui/domain/models/warning.dart';

class Instruction {
  String id;
  String order;
  String text;
  ThreeDModel threeDmodel;
  Warning warning;
  Instruction({
    required this.id,
    required this.order,
    required this.text,
    required this.threeDmodel,
    required this.warning,
  });

  Instruction copyWith({
    String? id,
    String? order,
    String? text,
    ThreeDModel? threeDmodel,
    Warning? warning,
  }) {
    return Instruction(
      id: id ?? this.id,
      order: order ?? this.order,
      text: text ?? this.text,
      threeDmodel: threeDmodel ?? this.threeDmodel,
      warning: warning ?? this.warning,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order': order,
      'text': text,
      'threeDmodel': threeDmodel.toMap(),
      'warning': warning.toMap(),
    };
  }

  factory Instruction.fromMap(Map<String, dynamic> map) {
    return Instruction(
      id: map['id'] as String,
      order: map['order'] as String,
      text: map['text'] as String,
      threeDmodel:
          ThreeDModel.fromMap(map['threeDmodel'] as Map<String, dynamic>),
      warning: Warning.fromMap(map['warning'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Instruction.fromJson(String source) =>
      Instruction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Instruction(id: $id, order: $order, text: $text, threeDmodel: $threeDmodel, warning: $warning)';
  }

  @override
  bool operator ==(covariant Instruction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order == order &&
        other.text == text &&
        other.threeDmodel == threeDmodel &&
        other.warning == warning;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        text.hashCode ^
        threeDmodel.hashCode ^
        warning.hashCode;
  }
}
