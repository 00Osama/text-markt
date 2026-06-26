import 'package:text_markt/features/events/domain/repositories/events_repository.dart';

class AddEventUseCase {
  final EventsRepository repository;

  AddEventUseCase({required this.repository});

  Future<String> call(String title, String note, DateTime dateTime) {
    return repository.addEvent(title, note, dateTime);
  }
}
