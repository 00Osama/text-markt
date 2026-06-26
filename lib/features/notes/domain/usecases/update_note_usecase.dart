import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class UpdateNoteUseCase {
  final NotesRepository repository;

  UpdateNoteUseCase({required this.repository});

  Future<void> call(
    String? note,
    String? title,
    String collection,
    String? docId,
    Timestamp time,
    String? status,
  ) {
    return repository.updateNote(note, title, collection, docId, time, status);
  }
}
