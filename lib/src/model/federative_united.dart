import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LivingState {
  int id;
  String acronym;
  String name;
  LivingState({
    required this.id,
    required this.acronym,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'acronym': acronym,
      'name': name,
    };
  }

  factory LivingState.fromMap(Map<String, dynamic> map) {
    return LivingState(
      id: map['id'] as int,
      acronym: map['sigla'] as String,
      name: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LivingState.fromJson(String source) =>
      LivingState.fromMap(json.decode(source) as Map<String, dynamic>);
}
