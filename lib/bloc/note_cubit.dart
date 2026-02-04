import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteState {}

class AllNotes extends NoteState {}

class Favourites extends NoteState {}

class Hidden extends NoteState {}

class Trash extends NoteState {}

class NoteLoading extends NoteState {}

class NoteAddSuccess extends NoteState {
  final String id;

  NoteAddSuccess({required this.id});
}

class NoteAddFail extends NoteState {}

class NoteUpdateSuccess extends NoteState {
  final String collection;
  final String id;

  NoteUpdateSuccess({
    required this.collection,
    required this.id,
  });
}

class NoteUpdateFail extends NoteState {}

class NoteMovedLoading extends NoteState {}

class NoteMovedSuccess extends NoteState {
  final int index;
  final String newCollection;
  final String oldCollection;
  final String title;
  final String note;
  final String id;

  NoteMovedSuccess({
    required this.index,
    required this.newCollection,
    required this.oldCollection,
    required this.title,
    required this.note,
    required this.id,
  });
}

class NoteMovedFail extends NoteState {
  final String collection;

  NoteMovedFail({
    required this.collection,
  });
}

class NoteDeleteSuccess extends NoteState {
  final int index;

  NoteDeleteSuccess({
    required this.index,
  });
}

class NoteDeleteFail extends NoteState {}

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
      // Add a new document and get its DocumentReference
      DocumentReference docRef = await FirebaseFirestore.instance
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

      // Access the document ID from the DocumentReference
      String newDocId = docRef.id;

      // Emit the success state with the new document ID
      emit(NoteAddSuccess(id: newDocId));
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
      emit(NoteUpdateSuccess(collection: collection, id: docId!));
      if (collection == 'AllNotes') {
        emit(AllNotes());
      } else if (collection == 'Favourites') {
        emit(Favourites());
      } else if (collection == 'Hidden') {
        emit(Hidden());
      } else {
        emit(Trash());
      }
    } on FirebaseException {
      emit(NoteUpdateFail());
    }
  }

  void deleteNote(
    String? docId,
    int index,
  ) async {
    try {
      emit(NoteMovedLoading());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Trash')
          .doc(docId)
          .delete();
      emit(NoteDeleteSuccess(index: index));
      emit(Trash());
    } on FirebaseException {
      emit(NoteDeleteFail());
    }
  }

  void moveNote(
    String? note,
    String? title,
    String oldCollection,
    String newCollection,
    String? docId,
    int index,
  ) async {
    try {
      emit(NoteMovedLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(oldCollection)
          .doc(docId)
          .delete();
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(newCollection)
          .add(
        {
          'title': title ?? '',
          'note': note ?? '',
          'time': Timestamp.now(),
        },
      );
      emit(NoteMovedSuccess(
        index: index,
        newCollection: newCollection,
        oldCollection: oldCollection,
        title: title ?? '',
        note: note ?? '',
        id: docRef.id,
      ));

      if (oldCollection == 'AllNotes') {
        emit(AllNotes());
      } else if (oldCollection == 'Favourites') {
        emit(Favourites());
      } else if (oldCollection == 'Hidden') {
        emit(Hidden());
      }
    } on FirebaseException {
      emit(NoteMovedFail(
        collection: newCollection,
      ));
    }
  }
}
