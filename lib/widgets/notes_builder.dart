import 'package:flutter/material.dart';
import 'package:textmarkt/models/note.dart';
import 'package:textmarkt/widgets/note_item.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteItem(note: note);
      },
    );
  }
}
