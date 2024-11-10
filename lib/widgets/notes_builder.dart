import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/note.dart';
import 'package:textmarkt/pages/sub_pages/create_or_update_note.dart';
import 'package:textmarkt/widgets/note_item.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({
    super.key,
    required this.notes,
    required this.collection,
  });

  final List<Note> notes;
  final String collection;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrUpdateNote(
                  operation: 'update',
                  note: note,
                  collection: collection,
                  index: index,
                ),
              ),
            );
          },
          child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection('Favourites')
                        .add({
                      'title': note.title,
                      'note': note.note,
                      'time': Timestamp.now(),
                    });
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection(collection)
                        .doc(note.id)
                        .delete();
                    favourites = [];
                  },
                  backgroundColor: const Color(0xffF7CE45),
                  foregroundColor: Colors.white,
                  icon: Icons.favorite_outline_rounded,
                  label: 'add to favourites',
                  borderRadius: BorderRadius.circular(13),
                ),
                SlidableAction(
                  onPressed: (context) {
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection('Hidden')
                        .add({
                      'title': note.title,
                      'note': note.note,
                      'time': Timestamp.now(),
                    });
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection(collection)
                        .doc(note.id)
                        .delete();
                    hidden = [];
                  },
                  backgroundColor: const Color(0xff4E94F8),
                  foregroundColor: Colors.white,
                  icon: FontAwesomeIcons.eyeSlash,
                  label: 'hide',
                  borderRadius: BorderRadius.circular(13),
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection('Trash')
                        .add({
                      'title': note.title,
                      'note': note.note,
                      'time': Timestamp.now(),
                    });
                    firestore
                        .collection('users')
                        .doc(auth.currentUser!.email)
                        .collection(collection)
                        .doc(note.id)
                        .delete();
                    trash = [];
                  },
                  backgroundColor: const Color(0xffEB4D3D),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'delete',
                  borderRadius: BorderRadius.circular(13),
                ),
              ],
            ),
            child: NoteItem(
              note: note,
            ),
          ),
        );
      },
    );
  }
}
