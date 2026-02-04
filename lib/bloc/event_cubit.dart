import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        dateTime: dateTime,
        id: response.id,
      ));
    } catch (e) {
      emit(EventAddFail());
    }
  }

  Future<void> deleteEvent(String? id, int index) async {
    try {
      emit(EventDeleteLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('events')
          .doc(id)
          .delete();
      emit(EventDeleteSuccess(index: index));
    } catch (e) {
      emit(EventDeleteFail());
    }
  }
}
