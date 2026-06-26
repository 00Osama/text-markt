import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.title,
    required super.note,
    required super.time,
    required super.status,
    super.id,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      title: data['title'] ?? '',
      note: data['note'] ?? '',
      time: data['time'] ?? Timestamp.now(),
      status: data['status'] ?? 'pending',
      id: doc.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'time': time,
      'status': status,
    };
  }
}
