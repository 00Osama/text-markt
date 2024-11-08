import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String note;
  final Timestamp time;

  Note({
    required this.title,
    required this.note,
    required this.time,
  });

  factory Note.fromJson(json) {
    return Note(
      title: json['title'],
      note: json['note'],
      time: json['time'],
    );
  }
}
