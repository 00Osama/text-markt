import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String note;
  final String status;
  final Timestamp time;
  String? id;
  String? noteType;

  Note({
    required this.title,
    required this.note,
    required this.time,
    required this.status,
    this.id,
  });
}
