class Event {
  final String note;
  final String title;
  final DateTime dateTime;
  String? id;

  Event({
    required this.note,
    required this.title,
    required this.dateTime,
    this.id,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      note: json['note'] ?? '',
      title: json['title'] ?? '',
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'])
          : DateTime.now(),
      id: json['id'],
    );
  }
}
