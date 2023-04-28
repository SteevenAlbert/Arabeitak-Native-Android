// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tool {
  String id;
  String name;
  Tool({
    required this.id,
    required this.name,
  });

  Tool copyWith({
    String? id,
    String? name,
  }) {
    return Tool(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tool.fromJson(String source) =>
      Tool.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tool(id: $id, name: $name)';

  @override
  bool operator ==(covariant Tool other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
