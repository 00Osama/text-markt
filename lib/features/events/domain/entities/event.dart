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
}
