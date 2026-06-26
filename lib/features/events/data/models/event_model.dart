import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.note,
    required super.title,
    required super.dateTime,
    super.id,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      note: data['note'] ?? '',
      title: data['title'] ?? '',
      dateTime: data['dateTime'] != null
          ? DateTime.parse(data['dateTime'])
          : DateTime.now(),
      id: doc.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
