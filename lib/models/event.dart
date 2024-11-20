class Event {
  final String note;
  final String title;
  final String dateTime;
  String? id;

  Event({
    required this.note,
    required this.title,
    required this.dateTime,
    this.id,
  });

  factory Event.fromJson(json) {
    return Event(
      note: json['note'] ?? '',
      title: json['title'] ?? '',
      dateTime: json['dateTime'] ?? '',
    );
  }
}
