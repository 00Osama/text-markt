import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:text_markt/core/routing/app_router.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/features/notes/presentation/cubits/note_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/presentation/widgets/note_item.dart';
import 'package:text_markt/core/widgets/swipe_item.dart';

class NotesBuilder extends StatefulWidget {
  const NotesBuilder({
    super.key,
    required this.notes,
    required this.currentCollection,
    this.searchQuery = '',
  });

  final List<Note> notes;
  final String currentCollection;
  final String searchQuery;

  @override
  State<NotesBuilder> createState() => _NotesBuilderState();
}

class _NotesBuilderState extends State<NotesBuilder> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isUnlocked = false;

  Future<String?> getHiddenNotesPin() async {
    return context.read<NoteCubit>().getHiddenNotesPin();
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
                  widget.notes[index].status,
                );
              },
              backgroundColor: const Color(0xffF7CE45),
              foregroundColor: Colors.white,
              icon: Icons.favorite_outline_rounded,
              label: S.of(context).favourite,
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
                  widget.notes[index].status,
                );
              },
              backgroundColor: const Color(0xff4E94F8),
              foregroundColor: Colors.white,
              icon: Icons.visibility_off_rounded,
              label: S.of(context).hide,
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
                  widget.notes[index].status,
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
          status: widget.notes[index].status,
          highlightQuery: widget.searchQuery,
        ),
      );
    } else if (widget.currentCollection == 'Favourites') {
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
                  widget.notes[index].status,
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
          status: widget.notes[index].status,
          highlightQuery: widget.searchQuery,
        ),
      );
    } else if (widget.currentCollection == 'Hidden') {
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
                  widget.notes[index].status,
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
          status: widget.notes[index].status,
          highlightQuery: widget.searchQuery,
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
          status: widget.notes[index].status,
          highlightQuery: widget.searchQuery,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentCollection == 'Hidden') {
      return FutureBuilder<String?>(
        future: getHiddenNotesPin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: const Color.fromARGB(255, 67, 143, 224),
                size: 90,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/hiddenNotesPin.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    S.of(context).noPinSet,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            );
          } else if (!_isUnlocked) {
            return Column(
              children: [
                const Swipeitem(),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: widget.notes.length,
                        itemBuilder: (context, index) {
                          return NoteItem(
                            note: widget.notes[index].note,
                            title: widget.notes[index].title,
                            status: widget.notes[index].status,
                            highlightQuery: widget.searchQuery,
                          );
                        },
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Center(
                          child: Container(
                            height: 150,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
                              controller: _passwordController,
                              cursorColor:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[200]
                                  : Colors.grey[500],
                              onChanged: (value) {
                                if (value.length == 4) {
                                  if (value == snapshot.data) {
                                    FocusScope.of(context).unfocus();
                                    _passwordController.clear();
                                    setState(() {
                                      _isUnlocked = true;
                                    });
                                  } else {
                                    errorSnackBar(
                                      context: context,
                                      title: S.of(context).incorrectPin,
                                    );
                                    _passwordController.clear();
                                  }
                                }
                              },
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
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
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                const Swipeitem(),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: widget.notes.length,
                        itemBuilder: (context, index) {
                          final note = widget.notes[index];
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                AppRoutes.noteEditor,
                                extra: NoteEditorRouteExtra(
                                  operation: 'update',
                                  note: note,
                                  collection: widget.currentCollection,
                                  index: index,
                                ),
                              );
                            },
                            child: showSlidables(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      );
    }

    // باقي الكولكشنز (غير Hidden)
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
                  context.push(
                    AppRoutes.noteEditor,
                    extra: NoteEditorRouteExtra(
                      operation: 'update',
                      note: note,
                      collection: widget.currentCollection,
                      index: index,
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
