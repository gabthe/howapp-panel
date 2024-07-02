import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/event_tag.dart';

class EventRepo {
  final CollectionReference eventTagsCollection =
      FirebaseFirestore.instance.collection('event_tags');
  Future<void> addTag({required EventTag eventTag}) async {
    try {
      await eventTagsCollection.doc(eventTag.id).set(eventTag.toMap());
      print('Tag criada ${eventTag.tagName}');
    } on FirebaseException catch (e) {
      print('Firebase exception $e');
    } catch (e, st) {
      log('Erro ao criar tag', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<List<EventTag>> getAllEventTags() async {
    try {
      QuerySnapshot querySnapshot = await eventTagsCollection.get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<EventTag> eventTags = docs.map((doc) {
        return EventTag.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return eventTags;
    } on FirebaseException catch (e) {
      print('Firebase exception $e');
      rethrow;
    } catch (e, st) {
      log('Erro ao buscar todas as tags', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> addTypeOfPlace({required EventTag eventTag}) async {
    try {
      CollectionReference eventTags =
          FirebaseFirestore.instance.collection('type_of_place');

      await eventTags.doc(eventTag.id).set(
            eventTag.toMap(),
          );
      print('Tag criada ${eventTag.tagName}');
    } on FirebaseException catch (e) {
      print('Firebae excpetion $e');
    } catch (e, st) {
      log('Erro ao criar tag', error: e, stackTrace: st);
      rethrow;
    }
  }
}

final eventRepoProvider = Provider<EventRepo>((ref) {
  return EventRepo();
});
