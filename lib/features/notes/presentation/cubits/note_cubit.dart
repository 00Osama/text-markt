import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/move_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:text_markt/globals.dart';

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

  NoteUpdateSuccess({required this.collection, required this.id});
}

class NoteUpdateFail extends NoteState {}

class NoteMovedLoading extends NoteState {}

class NoteMovedSuccess extends NoteState {
  final int index;
  final String newCollection;
  final String oldCollection;
  final String title;
  final String note;
  final String status;
  final String id;

  NoteMovedSuccess({
    required this.index,
    required this.newCollection,
    required this.oldCollection,
    required this.title,
    required this.status,
    required this.note,
    required this.id,
  });
}

class NoteMovedFail extends NoteState {
  final String collection;

  NoteMovedFail({required this.collection});
}

class NoteDeleteSuccess extends NoteState {
  final int index;

  NoteDeleteSuccess({required this.index});
}

class NoteDeleteFail extends NoteState {}

class NoteCubit extends Cubit<NoteState> {
  NoteCubit({
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.moveNoteUseCase,
    required this.getNotesUseCase,
  }) : super(AllNotes());

  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final MoveNoteUseCase moveNoteUseCase;
  final GetNotesUseCase getNotesUseCase;

  Future<List<Note>> getNotesData(String collection) async {
    if (collection == 'AllNotes') {
      if (allNotes.isEmpty) {
        allNotes = List<Note>.from(await getNotesUseCase(collection));
      }
      return allNotes;
    } else if (collection == 'Favourites') {
      if (favourites.isEmpty) {
        favourites = List<Note>.from(await getNotesUseCase(collection));
      }
      return favourites;
    } else if (collection == 'Hidden') {
      if (hidden.isEmpty) {
        hidden = List<Note>.from(await getNotesUseCase(collection));
      }
      return hidden;
    } else {
      if (trash.isEmpty) {
        trash = List<Note>.from(await getNotesUseCase(collection));
      }
      return trash;
    }
  }

  Future<String?> getHiddenNotesPin() {
    return getNotesUseCase.getHiddenNotesPin();
  }

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

  void addNewNote(String? note, String? title, String? status) async {
    try {
      String newDocId = await addNoteUseCase(note, title, status);
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
    String? status,
  ) async {
    try {
      await updateNoteUseCase(note, title, collection, docId, time, status);
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
    } catch (e) {
      emit(NoteUpdateFail());
    }
  }

  void deleteNote(String? docId, int index) async {
    try {
      emit(NoteMovedLoading());
      await deleteNoteUseCase(docId);
      emit(NoteDeleteSuccess(index: index));
      emit(Trash());
    } catch (e) {
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
    String status,
  ) async {
    try {
      emit(NoteMovedLoading());
      String newDocId = await moveNoteUseCase(
        note,
        title,
        oldCollection,
        newCollection,
        docId,
        status,
      );
      emit(
        NoteMovedSuccess(
          index: index,
          newCollection: newCollection,
          oldCollection: oldCollection,
          title: title ?? '',
          note: note ?? '',
          id: newDocId,
          status: status,
        ),
      );

      if (oldCollection == 'AllNotes') {
        emit(AllNotes());
      } else if (oldCollection == 'Favourites') {
        emit(Favourites());
      } else if (oldCollection == 'Hidden') {
        emit(Hidden());
      }
    } catch (e) {
      emit(NoteMovedFail(collection: newCollection));
    }
  }
}
