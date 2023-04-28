// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ThreeDModel {
  String id;
  String path;
  String animation;
  ThreeDModel({
    required this.id,
    required this.path,
    required this.animation,
  });

  ThreeDModel copyWith({
    String? id,
    String? path,
    String? animation,
  }) {
    return ThreeDModel(
      id: id ?? this.id,
      path: path ?? this.path,
      animation: animation ?? this.animation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'animation': animation,
    };
  }

  factory ThreeDModel.fromMap(Map<String, dynamic> map) {
    return ThreeDModel(
      id: map['id'] as String,
      path: map['path'] as String,
      animation: map['animation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThreeDModel.fromJson(String source) =>
      ThreeDModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ThreeDModel(id: $id, path: $path, animation: $animation)';

  @override
  bool operator ==(covariant ThreeDModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.path == path && other.animation == animation;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode ^ animation.hashCode;
}
