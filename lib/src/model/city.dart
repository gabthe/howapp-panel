import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class City {
  int id;
  String name;
  int ufId;
  String ufName;
  String ufAbreviation;
  String region;
  City({
    required this.id,
    required this.name,
    required this.ufId,
    required this.ufName,
    required this.ufAbreviation,
    required this.region,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'municipio-id': id,
      'municipio-nome': name,
      'UF-id': ufId,
      'UF-nome': ufName,
      'UF-sigla': ufAbreviation,
      'regiao-nome': region,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['municipio-id'] as int,
      name: map['municipio-nome'] as String,
      ufId: map['UF-id'] as int,
      ufName: map['UF-nome'] as String,
      ufAbreviation: map['UF-sigla'] as String,
      region: map['regiao-nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);
}
