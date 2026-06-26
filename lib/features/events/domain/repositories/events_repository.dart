import 'package:text_markt/features/events/domain/entities/event.dart';

abstract class EventsRepository {
  Stream<List<Event>> getEvents();

  Future<String> addEvent(String title, String note, DateTime dateTime);

  Future<void> deleteEvent(String? id);
}
