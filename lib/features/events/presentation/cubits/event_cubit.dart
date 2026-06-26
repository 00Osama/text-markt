import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/events/domain/usecases/add_event_usecase.dart';
import 'package:text_markt/features/events/domain/usecases/delete_event_usecase.dart';
import 'package:text_markt/features/events/domain/usecases/get_events_usecase.dart';

class EventState {}

class EventIntial extends EventState {
  final String? firstId;

  EventIntial({this.firstId});
}

class EventAddLoading extends EventState {}

class EventAddSuccess extends EventState {
  final String title;
  final String note;
  final DateTime dateTime;
  final String id;

  EventAddSuccess({
    required this.title,
    required this.note,
    required this.dateTime,
    required this.id,
  });
}

class EventAddFail extends EventState {}

class EventDeleteLoading extends EventState {}

class EventDeleteSuccess extends EventState {
  final int index;

  EventDeleteSuccess({required this.index});
}

class EventDeleteFail extends EventState {}

class EventCubit extends Cubit<EventState> {
  EventCubit({
    required this.addEventUseCase,
    required this.deleteEventUseCase,
    required this.getEventsUseCase,
  }) : super(EventIntial());

  final AddEventUseCase addEventUseCase;
  final DeleteEventUseCase deleteEventUseCase;
  final GetEventsUseCase getEventsUseCase;

  Stream<List<Event>> getEvents() {
    return getEventsUseCase();
  }

  Future<void> addNewEvent(String title, String note, DateTime dateTime) async {
    try {
      emit(EventAddLoading());
      final id = await addEventUseCase(title, note, dateTime);
      emit(EventAddSuccess(
        title: title,
        note: note,
        dateTime: dateTime,
        id: id,
      ));
    } catch (e) {
      emit(EventAddFail());
    }
  }

  Future<void> deleteEvent(String? id, int index) async {
    try {
      emit(EventDeleteLoading());
      await deleteEventUseCase(id);
      emit(EventDeleteSuccess(index: index));
    } catch (e) {
      emit(EventDeleteFail());
    }
  }
}
