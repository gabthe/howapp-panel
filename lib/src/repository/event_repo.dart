import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/event_tag.dart';

class EventRepo {
  Future<void> addTag({required EventTag eventTag}) async {
    try {
      CollectionReference eventTags =
          FirebaseFirestore.instance.collection('event_tags');

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
