// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class CommerceType {
  String id;
  String commerceTypeName;

  CommerceType({
    String? id, // Allow null id to generate one if not provided
    required this.commerceTypeName,
  }) : id = id ?? const Uuid().v4(); // Generate a new UUID if id is null

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'commerceTypeName': commerceTypeName,
    };
  }

  factory CommerceType.fromMap(Map<String, dynamic> map) {
    return CommerceType(
      id: map['id'] as String,
      commerceTypeName: map['commerceTypeName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommerceType.fromJson(String source) =>
      CommerceType.fromMap(json.decode(source) as Map<String, dynamic>);
}
