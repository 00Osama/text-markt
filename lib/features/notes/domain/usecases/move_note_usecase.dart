import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class MoveNoteUseCase {
  final NotesRepository repository;

  MoveNoteUseCase({required this.repository});

  Future<String> call(
    String? note,
    String? title,
    String oldCollection,
    String newCollection,
    String? docId,
    String status,
  ) {
    return repository.moveNote(
      note,
      title,
      oldCollection,
      newCollection,
      docId,
      status,
    );
  }
}
