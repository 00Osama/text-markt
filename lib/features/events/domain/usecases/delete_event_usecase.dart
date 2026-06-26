import 'package:text_markt/features/events/domain/repositories/events_repository.dart';

class DeleteEventUseCase {
  final EventsRepository repository;

  DeleteEventUseCase({required this.repository});

  Future<void> call(String? id) {
    return repository.deleteEvent(id);
  }
}
