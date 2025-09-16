import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String note;
  final Timestamp time;
  String? id;
  String? noteType;

  Note({
    required this.title,
    required this.note,
    required this.time,
    this.id,
  });

  factory Note.fromJson(json) {
    return Note(
      title: json['title'],
      note: json['note'],
      time: json['time'],
    );
  }
}
