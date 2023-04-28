// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Manufacturer {
  String mid;
  String name;
  String url;
  String desc;
  Manufacturer({
    required this.mid,
    required this.name,
    required this.url,
    required this.desc,
  });

  Manufacturer copyWith({
    String? mid,
    String? name,
    String? url,
    String? desc,
  }) {
    return Manufacturer(
      mid: mid ?? this.mid,
      name: name ?? this.name,
      url: url ?? this.url,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mid': mid,
      'name': name,
      'url': url,
      'desc': desc,
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      mid: map['mid'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
      desc: map['desc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Manufacturer(mid: $mid, name: $name, url: $url, desc: $desc)';
  }

  @override
  bool operator ==(covariant Manufacturer other) {
    if (identical(this, other)) return true;

    return other.mid == mid &&
        other.name == name &&
        other.url == url &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return mid.hashCode ^ name.hashCode ^ url.hashCode ^ desc.hashCode;
  }
}
