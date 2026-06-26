import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class DeleteNoteUseCase {
  final NotesRepository repository;

  DeleteNoteUseCase({required this.repository});

  Future<void> call(String? docId) {
    return repository.deleteNote(docId);
  }
}
