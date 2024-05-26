// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:howapp_panel/src/model/city.dart';
import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/model/profile.dart';

class PersonalProfile extends Profile {
  String gender;
  List<Event> checkedInEvents;
  List<Event> eventsOfInterest;

  PersonalProfile({
    super.phoneNumber,
    super.photoUrl,
    super.displayName,
    required this.gender,
    required this.checkedInEvents,
    required this.eventsOfInterest,
    required super.firebaseId,
    required super.username,
    required super.email,
    required super.city,
    required super.isAdmin,
    required super.isComercial,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city.toMap(),
      'email': email,
      'firebaseId': firebaseId,
      'isAdmin': isAdmin,
      'username': username,
      'isComercial': isComercial,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'gender': gender,
      'checkedInEvents': checkedInEvents.map((x) => x.toMap()).toList(),
      'eventsOfInterest': eventsOfInterest.map((x) => x.toMap()).toList(),
    };
  }

  factory PersonalProfile.fromMap(Map<String, dynamic> map) {
    print('citymap ${map['city']}');
    print('ALLMAP ${map}');
    return PersonalProfile(
      city: City.fromMap(map['city']),
      email: map['email'],
      firebaseId: map['firebaseId'],
      isAdmin: map['isAdmin'],
      username: map['username'],
      isComercial: map['isComercial'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      gender: map['gender'] as String,
      checkedInEvents: List<Event>.from(
        (map['checkedInEvents'] as List<dynamic>).map<Event>(
          (x) => Event.fromMap(x as Map<String, dynamic>),
        ),
      ),
      eventsOfInterest: List<Event>.from(
        (map['eventsOfInterest'] as List<dynamic>).map<Event>(
          (x) => Event.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalProfile.fromJson(String source) =>
      PersonalProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
