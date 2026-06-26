import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/notes/data/datasources/notes_remote_datasource.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;

  NotesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Note>> getNotes(String collection) {
    return remoteDataSource.getNotes(collection);
  }

  @override
  Future<String?> getHiddenNotesPin() {
    return remoteDataSource.getHiddenNotesPin();
  }

  @override
  Future<String> addNote(String? note, String? title, String? status) {
    return remoteDataSource.addNote(note, title, status);
  }

  @override
  Future<void> updateNote(
    String? note,
    String? title,
    String collection,
    String? docId,
    Timestamp time,
    String? status,
  ) {
    return remoteDataSource.updateNote(
      note,
      title,
      collection,
      docId,
      time,
      status,
    );
  }

  @override
  Future<void> deleteNote(String? docId) {
    return remoteDataSource.deleteNote(docId);
  }

  @override
  Future<String> moveNote(
    String? note,
    String? title,
    String oldCollection,
    String newCollection,
    String? docId,
    String status,
  ) {
    return remoteDataSource.moveNote(
      note,
      title,
      oldCollection,
      newCollection,
      docId,
      status,
    );
  }
}
