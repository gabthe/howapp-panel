import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/commercial_profile.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<CommercialProfile>> getAllComercialProfiles() async {
    try {
      // pegar user do firebase
      QuerySnapshot querySnapshot =
          await _firestore.collection('commercial_profiles').get();
      return querySnapshot.docs
          .map((doc) =>
              CommercialProfile.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
      // tratar erro
    }
  }
}

final userRepoProvider = Provider<UserRepo>(
  (ref) {
    return UserRepo();
  },
);
