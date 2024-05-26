// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:howapp_panel/src/model/city.dart';

abstract class Profile {
  String firebaseId;
  String username;
  String email;
  String? displayName;
  String? photoUrl;
  String? phoneNumber;
  bool isAdmin;
  bool isComercial;
  City city;
  Profile({
    this.photoUrl,
    this.phoneNumber,
    this.displayName,
    required this.isComercial,
    required this.firebaseId,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.city,
  });
}
