import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/events/data/models/event_model.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';

class EventsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  EventsRemoteDataSource({
    required this.auth,
    required this.firestore,
  });

  CollectionReference<Map<String, dynamic>> get eventsCollection {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.email)
        .collection('events');
  }

  Stream<List<Event>> getEvents() {
    return eventsCollection
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    });
  }

  Future<String> addEvent(String title, String note, DateTime dateTime) async {
    final response = await eventsCollection.add({
      'title': title,
      'note': note,
      'dateTime': dateTime.toIso8601String(),
    });

    return response.id;
  }

  Future<void> deleteEvent(String? id) async {
    await eventsCollection.doc(id).delete();
  }
}
