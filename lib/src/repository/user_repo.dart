import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/commercial_profile.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ComercialProfile>?> fetchUsersOnce() async {
    try {
      print("rodei");
      final querySnapshot = await _firestore
          .collection('users')
          .where('isComercial', isEqualTo: true)
          .get();
      print(querySnapshot.docs.length);
      return null;
    } catch (e, st) {
      log(
        "user_repo_error",
        error: e,
        stackTrace: st,
      );
    }
  }
}

final userRepoProvider = Provider<UserRepo>(
  (ref) {
    return UserRepo();
  },
);
