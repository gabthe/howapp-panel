// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:howapp_panel/src/model/activity.dart';
import 'package:howapp_panel/src/model/personal_profile.dart';
import 'package:uuid/uuid.dart';

class Event {
  late String id;
  String? publisherId;
  bool isHighlighted;
  String name;
  String description;
  bool hasTicket;
  bool hasSuggestedLook;
  List<PersonalProfile> interestedList;
  List<Activity> schedule;
  String photoURL;
  String commerceName;
  String bannerURL;
  String address;
  String city;
  String livingState;
  double latitude;
  double longitude;
  DateTime startingDate;
  DateTime finishDate;
  Event({
    String? id,
    this.publisherId,
    required this.isHighlighted,
    required this.name,
    required this.description,
    required this.hasTicket,
    required this.hasSuggestedLook,
    required this.interestedList,
    required this.schedule,
    required this.photoURL,
    required this.commerceName,
    required this.bannerURL,
    required this.address,
    required this.city,
    required this.livingState,
    required this.latitude,
    required this.longitude,
    required this.startingDate,
    required this.finishDate,
  }) : id = id ?? const Uuid().v4();
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publisherId': publisherId,
      'isHighlighted': isHighlighted,
      'name': name,
      'description': description,
      'hasTicket': hasTicket,
      'hasSuggestedLook': hasSuggestedLook,
      'interestedList': interestedList.map((x) => x.toMap()).toList(),
      'schedule': schedule.map((x) => x.toMap()).toList(),
      'photoURL': photoURL,
      'commerceName': commerceName,
      'bannerURL': bannerURL,
      'address': address,
      'city': city,
      'livingState': livingState,
      'latitude': latitude,
      'longitude': longitude,
      'startingDate': startingDate.millisecondsSinceEpoch,
      'finishDate': finishDate.millisecondsSinceEpoch,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map["id"] as String,
      publisherId:
          map['publisherId'] != null ? map['publisherId'] as String : null,
      isHighlighted: map['isHighlighted'] as bool,
      name: map['name'] as String,
      description: map['description'] as String,
      hasTicket: map['hasTicket'] as bool,
      hasSuggestedLook: map['hasSuggestedLook'] as bool,
      interestedList: List<PersonalProfile>.from(
        (map['interestedList'] as List<dynamic>).map<PersonalProfile>(
          (x) => PersonalProfile.fromMap(x as Map<String, dynamic>),
        ),
      ),
      schedule: List<Activity>.from(
        (map['schedule'] as List<dynamic>).map<Activity>(
          (x) => Activity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      photoURL: map['photoURL'] as String,
      commerceName: map['commerceName'] != null
          ? map['commerceName'] as String
          : "Gabiru Eventos",
      bannerURL: map['bannerURL'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      livingState: map['livingState'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      startingDate:
          DateTime.fromMillisecondsSinceEpoch(map['startingDate'] as int),
      finishDate: DateTime.fromMillisecondsSinceEpoch(map['finishDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(id: $id, name: $name, description: $description, hasTicket: $hasTicket, hasSuggestedLook: $hasSuggestedLook, interestedList: $interestedList, schedule: $schedule, photoURL: $photoURL, bannerURL: $bannerURL, address: $address, city: $city, livingState: $livingState, latitude: $latitude, longitude: $longitude, startingDate: $startingDate, finishDate: $finishDate)';
  }
}
