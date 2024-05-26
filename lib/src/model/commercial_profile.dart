// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/model/profile.dart';

class ComercialProfile extends Profile {
  List<Event> publishedEvents;
  String commerceType;

  ComercialProfile({
    super.displayName,
    super.phoneNumber,
    super.photoUrl,
    required super.firebaseId,
    required super.isComercial,
    required super.username,
    required super.email,
    required super.city,
    required super.isAdmin,
    required this.publishedEvents,
    required this.commerceType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publishedEvents': publishedEvents.map((x) => x.toMap()).toList(),
      'commerceType': commerceType,
    };
  }

  factory ComercialProfile.fromMap(Map<String, dynamic> map) {
    return ComercialProfile(
      city: map['city'],
      email: map['email'],
      firebaseId: map['firebaseId'],
      isAdmin: map['isAdmin'],
      isComercial: map['isComercial'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      username: map['username'],
      displayName: map['displayName'],
      publishedEvents: List<Event>.from(
        (map['publishedEvents'] as List<int>).map<Event>(
          (x) => Event.fromMap(x as Map<String, dynamic>),
        ),
      ),
      commerceType: map['commerceType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComercialProfile.fromJson(String source) =>
      ComercialProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
