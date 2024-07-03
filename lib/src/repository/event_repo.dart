import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/model/commerce_type.dart';

enum ImageType {
  banner,
  profile,
  carouselBig,
  carouselSmall,
  cardImage,
  socialMedia,
}

class EventRepo {
  final CollectionReference eventTagsCollection =
      FirebaseFirestore.instance.collection('event_tags');
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');
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

  Future<void> createEventInFirestore(Event event) async {
    try {
      await eventsCollection.doc(event.id).set(event.toMap());
      print('Evento criado: ${event.name}');
    } catch (e) {
      print('Erro ao criar evento no Firestore: $e');
      rethrow;
    }
  }

  Future<List<Event>> fetchAllEvents() async {
    try {
      // Obtém o snapshot da coleção de eventos
      QuerySnapshot querySnapshot = await eventsCollection.get();

      // Mapeia cada documento para um objeto Event e retorna a lista
      return querySnapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Erro ao buscar eventos no Firestore: $e');
      rethrow;
    }
  }

  Future<List<Event>> fetchAllNotHighlightedEvents() async {
    try {
      // Obtém o snapshot da coleção de eventos
      QuerySnapshot querySnapshot =
          await eventsCollection.where('isHighlighted', isEqualTo: false).get();

      // Mapeia cada documento para um objeto Event e retorna a lista
      return querySnapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Erro ao buscar eventos no Firestore: $e');
      rethrow;
    }
  }

  Future<void> updateEventHighlight(String eventId, int highlightIndex) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .update({
        'isHighlighted': true,
        'highlightIndex': highlightIndex,
      });
      print('Evento atualizado: $eventId');
    } catch (e) {
      print('Erro ao atualizar evento no Firestore: $e');
    }
  }

  Future<void> removeEventHighlight(String eventId) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .update({
        'isHighlighted': false,
        'highlightIndex': null,
      });
      print('Evento atualizado: $eventId');
    } catch (e) {
      print('Erro ao atualizar evento no Firestore: $e');
    }
  }

  Future<Event?> fetchEventById(String id) async {
    try {
      DocumentSnapshot docSnapshot = await eventsCollection.doc(id).get();
      if (docSnapshot.exists) {
        return Event.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        return null; // Evento não encontrado com o ID especificado
      }
    } catch (e) {
      print('Erro ao buscar evento por ID no Firestore: $e');
      rethrow;
    }
  }

  Future<String> uploadEventImageToFirestorage({
    required Uint8List memoryImage,
    required String eventName,
    required ImageType imageType,
    required String imageName,
  }) async {
    try {
      // Referência ao Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Nome do arquivo no Firebase Storage
      String fileName = 'files/$eventName/${imageType.name}/$imageName.jpg';

      // Cria uma referência ao local onde o arquivo será armazenado
      Reference ref = storage.ref().child(fileName);

      // Faz o upload do arquivo
      UploadTask uploadTask = ref.putData(memoryImage);

      // Espera a conclusão do upload
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtém a URL de download do arquivo
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      print('Upload concluído! URL de download: $downloadURL');
      return downloadURL;
    } catch (e) {
      print(e);
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

  Future<void> addTypeOfPlace({required CommerceType commerceType}) async {
    try {
      CollectionReference commerceTypes =
          FirebaseFirestore.instance.collection('commerce_types');

      await commerceTypes.doc(commerceType.id).set(
            commerceType.toMap(),
          );
      print('Tag criada ${commerceType.commerceTypeName}');
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
