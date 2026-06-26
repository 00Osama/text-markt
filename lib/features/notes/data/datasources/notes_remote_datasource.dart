import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/notes/data/models/note_model.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';

class NotesRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  NotesRemoteDataSource({
    required this.auth,
    required this.firestore,
  });

  CollectionReference<Map<String, dynamic>> notesCollection(String collection) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.email)
        .collection(collection);
  }

  Future<List<Note>> getNotes(String collection) async {
    final response = await notesCollection(collection)
        .orderBy('time', descending: true)
        .get();

    return response.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
  }

  Future<String?> getHiddenNotesPin() async {
    final snapshot = await notesCollection('Hidden').doc('hiddenNotesPin').get();

    if (!snapshot.exists) {
      return null;
    }
    return snapshot.data()?['pin'];
  }

  Future<String> addNote(String? note, String? title, String? status) async {
    final docRef = await notesCollection('AllNotes').add({
      'title': title ?? '',
      'note': note ?? '',
      'time': Timestamp.now(),
      'status': status ?? 'pending',
    });

    return docRef.id;
  }

  Future<void> updateNote(
    String? note,
    String? title,
    String collection,
    String? docId,
    Timestamp time,
    String? status,
  ) async {
    await notesCollection(collection).doc(docId).update({
      'title': title ?? '',
      'note': note ?? '',
      'time': time,
      'status': status ?? 'pending',
    });
  }

  Future<void> deleteNote(String? docId) async {
    await notesCollection('Trash').doc(docId).delete();
  }

  Future<String> moveNote(
    String? note,
    String? title,
    String oldCollection,
    String newCollection,
    String? docId,
    String status,
  ) async {
    await notesCollection(oldCollection).doc(docId).delete();
    final docRef = await notesCollection(newCollection).add({
      'title': title ?? '',
      'note': note ?? '',
      'time': Timestamp.now(),
      'status': status,
    });
    return docRef.id;
  }
}
