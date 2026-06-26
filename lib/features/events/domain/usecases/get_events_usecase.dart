import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/events/domain/repositories/events_repository.dart';

class GetEventsUseCase {
  final EventsRepository repository;

  GetEventsUseCase({required this.repository});

  Stream<List<Event>> call() {
    return repository.getEvents();
  }
}
