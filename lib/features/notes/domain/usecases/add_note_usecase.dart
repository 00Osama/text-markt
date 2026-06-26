import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase({required this.repository});

  Future<String> call(String? note, String? title, String? status) {
    return repository.addNote(note, title, status);
  }
}
