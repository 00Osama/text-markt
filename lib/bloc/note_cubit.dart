import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteState {}

class AllNotes extends NoteState {}

class Favourites extends NoteState {}

class Hidden extends NoteState {}

class Trash extends NoteState {}

class NoteAddSuccess extends NoteState {}

class NoteAddFail extends NoteState {}

class NoteUpdateSuccess extends NoteState {}

class NoteUpdateFail extends NoteState {}

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(AllNotes());

  void switchNotes(String note) {
    if (note == 'AllNotes') {
      emit(AllNotes());
    } else if (note == 'Favourites') {
      emit(Favourites());
    } else if (note == 'Hidden') {
      emit(Hidden());
    } else {
      emit(Trash());
    }
  }

  void addNewNote(String? note, String? title) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('AllNotes')
          .add(
        {
          'title': title ?? '',
          'note': note ?? '',
          'time': Timestamp.now(),
        },
      );
      emit(NoteAddSuccess());
      emit(AllNotes());
    } on Exception {
      emit(NoteAddFail());
    }
  }

  void updateNote(
    String? note,
    String? title,
    String collection,
    String? docId,
    Timestamp time,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(collection)
          .doc(docId)
          .update(
        {
          'title': title ?? '',
          'note': note ?? '',
          'time': time,
        },
      );
      emit(NoteUpdateSuccess());
      emit(AllNotes());
    } on Exception {
      emit(NoteUpdateFail());
    }
  }
}
