import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_markt/bloc/note_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/models/note.dart';
import 'package:text_markt/pages/sub_pages/create_or_update_note.dart';
import 'package:text_markt/widgets/note_item.dart';
import 'package:text_markt/widgets/swipe_item.dart';

class NotesBuilder extends StatefulWidget {
  const NotesBuilder({
    super.key,
    required this.notes,
    required this.currentCollection,
    required this.pin,
  });

  final List<Note> notes;
  final String currentCollection;
  final String pin;

  @override
  State<NotesBuilder> createState() => _NotesBuilderState();
}

class _NotesBuilderState extends State<NotesBuilder> {
  final TextEditingController _passwordController = TextEditingController();
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_passwordController.text.length == 4) {
        if (_passwordController.text == widget.pin) {
          setState(() {
            _unlocked = true;
          });
        } else {
          // clear on wrong input
          _passwordController.clear();
        }
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
    final notesList = ListView.builder(
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
    );

    if (widget.currentCollection == 'Hidden' && !_unlocked) {
      // locked view
      return Column(
        children: [
          const Swipeitem(),
          Expanded(
            child: Stack(
              children: [
                notesList,
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Center(
                    child: Container(
                      height: 150,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          cursorColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[200]
                              : Colors.grey[500],
                          controller: _passwordController,
                          obscureText: true,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[300]
                                : Colors.grey[600],
                            letterSpacing: 3,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Theme.of(
                              context,
                            ).inputDecorationTheme.fillColor,
                            hintText: S.of(context).pin,
                            hintStyle: Theme.of(
                              context,
                            ).inputDecorationTheme.hintStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[300]!
                                    : Colors.grey[600]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[300]!
                                    : Colors.grey[600]!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // normal unlocked view
    return Column(
      children: [
        const Swipeitem(),
        Expanded(child: notesList),
      ],
    );
  }
}
