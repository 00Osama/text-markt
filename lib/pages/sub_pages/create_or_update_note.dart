import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textmarkt/bloc/note_cubit.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/note.dart';

class CreateOrUpdateNote extends StatefulWidget {
  const CreateOrUpdateNote({
    super.key,
    required this.operation,
    this.index,
    this.collection,
    this.note,
  });

  final String operation;
  final String? collection;
  final int? index;
  final Note? note;

  @override
  State<CreateOrUpdateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateOrUpdateNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  late String newTitle;
  late String newNote;

  late String updatedTitle;
  late String updatedNote;

  @override
  void initState() {
    super.initState();

    if (widget.operation == 'update') {
      titleController.text = widget.note?.title ?? '';
      noteController.text = widget.note?.note ?? '';
    }

    // Initialize newTitle and newNote with the current text
    newTitle = titleController.text;
    newNote = noteController.text;

    // Add listeners to update newTitle and newNote on changes
    titleController.addListener(() {
      setState(() {
        newTitle = titleController.text;
      });
    });

    noteController.addListener(() {
      setState(() {
        newNote = noteController.text;
      });
    });
  }

  @override
  void dispose() {
    // Always dispose of controllers when no longer needed to avoid memory leaks
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        actions: [
          const Spacer(flex: 40),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                const Color(0xff1F2124),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            onPressed: widget.operation == 'add'
                ? () async {
                    if (titleController.text.trim().isEmpty &&
                        noteController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Enter at least a note title',
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      );

                      context.read<NoteCubit>().addNewNote(
                            noteController.text,
                            titleController.text,
                          );
                    }
                  }
                : () {
                    if (newTitle.trim().isEmpty && newNote.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Enter at least a note title',
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      );

                      updatedTitle = newTitle;
                      updatedNote = newNote;

                      String? id = widget.note?.id;

                      ////////////////////////////////////
                      context.read<NoteCubit>().updateNote(
                            newNote,
                            newTitle,
                            widget.collection!,
                            id,
                            widget.note!.time,
                          );
                    }
                  },
            child: Text(
              widget.operation == 'add' ? 'Save' : 'Update',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
      body: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteAddSuccess || state is NoteAddFail) {
            if (state is NoteAddSuccess) {
              allNotes.insert(
                0,
                Note(
                  title: titleController.text,
                  note: noteController.text,
                  time: Timestamp.now(),
                ),
              );

              Navigator.pop(context);
              Navigator.pop(context);
            }

            // Show success or error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state is NoteAddSuccess
                      ? 'Note added successfully'
                      : 'Failed to add note',
                  style: const TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                backgroundColor:
                    state is NoteAddSuccess ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          }
          if (state is NoteUpdateSuccess || state is NoteUpdateFail) {
            if (state is NoteUpdateSuccess) {
              allNotes[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                time: Timestamp.now(),
              );

              Navigator.pop(context);
              Navigator.pop(context);
            }

            // Show success or error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state is NoteUpdateSuccess
                      ? 'Note updated successfully'
                      : 'Failed to update note',
                  style: const TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                backgroundColor:
                    state is NoteUpdateSuccess ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  maxLines: null,
                  cursorColor: const Color(0xff007AFF),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 80, 78, 78),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff979797),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: noteController,
                  cursorColor: const Color(0xff007AFF),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff979797),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
