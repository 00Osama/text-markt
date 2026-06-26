import 'package:text_markt/features/events/data/datasources/events_remote_datasource.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  final EventsRemoteDataSource remoteDataSource;

  EventsRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Event>> getEvents() {
    return remoteDataSource.getEvents();
  }

  @override
  Future<String> addEvent(String title, String note, DateTime dateTime) {
    return remoteDataSource.addEvent(title, note, dateTime);
  }

  @override
  Future<void> deleteEvent(String? id) {
    return remoteDataSource.deleteEvent(id);
  }
}
