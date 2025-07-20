import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:textmarkt/bloc/note_cubit.dart';
import 'package:textmarkt/generated/l10n.dart';
import 'package:textmarkt/models/note.dart';
import 'package:textmarkt/pages/sub_pages/create_or_update_note.dart';
import 'package:textmarkt/widgets/note_item.dart';
import 'package:textmarkt/widgets/swipe_item.dart';

class NotesBuilder extends StatefulWidget {
  const NotesBuilder({
    super.key,
    required this.notes,
    required this.currentCollection,
  });

  final List<Note> notes;
  final String currentCollection;

  @override
  State<NotesBuilder> createState() => _NotesBuilderState();
}

class _NotesBuilderState extends State<NotesBuilder> {
  Widget showSlidables(int index) {
    if (widget.currentCollection == 'AllNotes') {
      return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<NoteCubit>().moveNote(
                      widget.notes[index].note,
                      widget.notes[index].title,
                      'AllNotes',
                      'Favourites',
                      widget.notes[index].id,
                      index,
                    );
              },
              backgroundColor: const Color(0xffF7CE45),
              foregroundColor: Colors.white,
              icon: Icons.favorite_outline_rounded,
              label: S.of(context).addToFavorites,
              borderRadius: BorderRadius.circular(13),
            ),
            SlidableAction(
              onPressed: (context) {
                context.read<NoteCubit>().moveNote(
                      widget.notes[index].note,
                      widget.notes[index].title,
                      'AllNotes',
                      'Hidden',
                      widget.notes[index].id,
                      index,
                    );
              },
              backgroundColor: const Color(0xff4E94F8),
              foregroundColor: Colors.white,
              icon: FontAwesomeIcons.eyeSlash,
              label: S.of(context).addToHidden,
              borderRadius: BorderRadius.circular(13),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<NoteCubit>().moveNote(
                      widget.notes[index].note,
                      widget.notes[index].title,
                      'AllNotes',
                      'Trash',
                      widget.notes[index].id,
                      index,
                    );
              },
              backgroundColor: const Color(0xffEB4D3D),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: S.of(context).moveToTrash,
              borderRadius: BorderRadius.circular(13),
            ),
          ],
        ),
        child: NoteItem(
          note: widget.notes[index].note,
          title: widget.notes[index].title,
        ),
      );
    } else if (widget.currentCollection == 'Favourites' ||
        widget.currentCollection == 'Hidden') {
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<NoteCubit>().moveNote(
                      widget.notes[index].note,
                      widget.notes[index].title,
                      widget.currentCollection,
                      'Trash',
                      widget.notes[index].id,
                      index,
                    );
              },
              backgroundColor: const Color(0xffEB4D3D),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: S.of(context).moveToTrash,
              borderRadius: BorderRadius.circular(13),
            ),
          ],
        ),
        child: NoteItem(
          note: widget.notes[index].note,
          title: widget.notes[index].title,
        ),
      );
    } else {
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<NoteCubit>().deleteNote(
                      widget.notes[index].id,
                      index,
                    );
              },
              backgroundColor: const Color(0xffEB4D3D),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: S.of(context).permanentlyDelete,
              borderRadius: BorderRadius.circular(13),
            ),
          ],
        ),
        child: NoteItem(
          note: widget.notes[index].note,
          title: widget.notes[index].title,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Swipeitem(),
        Expanded(
          child: ListView.builder(
            itemCount: widget.notes.length,
            itemBuilder: (context, index) {
              final note = widget.notes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateOrUpdateNote(
                        operation: 'update',
                        note: note,
                        collection: widget.currentCollection,
                        index: index,
                      ),
                    ),
                  );
                },
                child: showSlidables(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
