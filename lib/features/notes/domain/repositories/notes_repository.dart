import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes(String collection);

  Future<String?> getHiddenNotesPin();

  Future<String> addNote(String? note, String? title, String? status);

  Future<void> updateNote(
    String? note,
    String? title,
    String collection,
    String? docId,
    Timestamp time,
    String? status,
  );

  Future<void> deleteNote(String? docId);

  Future<String> moveNote(
    String? note,
    String? title,
    String oldCollection,
    String newCollection,
    String? docId,
    String status,
  );
}
