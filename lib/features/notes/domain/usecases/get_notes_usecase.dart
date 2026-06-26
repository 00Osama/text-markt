import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase({required this.repository});

  Future<List<Note>> call(String collection) {
    return repository.getNotes(collection);
  }

  Future<String?> getHiddenNotesPin() {
    return repository.getHiddenNotesPin();
  }
}
