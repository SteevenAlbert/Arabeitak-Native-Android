// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestingInstruction {
  TestingType type;
  String title;
  String text;
  
  TestingInstruction({
    required this.type,
    required this.title,
    required this.text,
  });

  TestingInstruction copyWith({
    TestingType? type,
    String? title,
    String? text,
  }) {
    return TestingInstruction(
      type: type ?? this.type,
      title: title ?? this.title,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'title': title,
      'text': text,
    };
  }

  factory TestingInstruction.fromMap(Map<String, dynamic> map) {
    return TestingInstruction(
      type: map['type'],
      title: map['title'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestingInstruction.fromJson(String source) => TestingInstruction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TestingStep(type: $type, title: $title, text: $text)';

  @override
  bool operator ==(covariant TestingInstruction other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      other.title == title &&
      other.text == text;
  }

  @override
  int get hashCode => type.hashCode ^ title.hashCode ^ text.hashCode;
}

enum TestingType {standard, danger, warning}
