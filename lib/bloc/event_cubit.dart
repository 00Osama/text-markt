import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventState {}

class EventIntial extends EventState {}

class EventAddLoading extends EventState {}

class EventChoose extends EventState {
  final String id;

  EventChoose({required this.id});
}

class EventAddSuccess extends EventState {
  final String title;
  final String note;
  final String dateTime;
  final String id;

  EventAddSuccess({
    required this.title,
    required this.note,
    required this.dateTime,
    required this.id,
  });
}

class EventAddFail extends EventState {}

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventIntial());

  Future<void> addNewEvent(String title, String note, DateTime dateTime) async {
    try {
      emit(EventAddLoading());
      DocumentReference response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('events')
          .add({
        'title': title,
        'note': note,
        'dateTime': dateTime.toIso8601String(),
      });
      emit(EventAddSuccess(
        title: title,
        note: note,
        dateTime: dateTime.toString(),
        id: response.id,
      ));
    } catch (e) {
      emit(EventAddFail());
    }
  }

  void chooseDay(String id) {
    emit(EventChoose(id: id));
  }
}
