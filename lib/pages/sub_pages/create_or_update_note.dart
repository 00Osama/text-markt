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
    this.currentDay,
    this.dayName,
    this.monthName,
  });

  final String operation;
  final String? collection;
  final int? index;
  final Note? note;
  final DateTime? currentDay;
  final String? dayName;
  final String? monthName;

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
        centerTitle: true,
        title: Text(
          widget.operation == 'add' ? 'Add New Note' : 'Update Note',
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width *
                0.045, // Responsive font size
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.02,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[400],
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              iconSize: MediaQuery.of(context).size.width * 0.06,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: widget.operation == 'add' || widget.operation == 'newEvent'
            ? () async {
                if (widget.operation == 'add') {
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
                } else {
                  ///////// add new event here
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
                  context.read<NoteCubit>().updateNote(
                        newNote,
                        newTitle,
                        widget.collection!,
                        id,
                        widget.note!.time,
                      );
                }
              },
        child: widget.operation == 'add'
            ? const Icon(Icons.save_rounded)
            : const Icon(Icons.edit_document),
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
                  id: state.id,
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

          if (state is NoteUpdateSuccess) {
            if (state.collection == 'AllNotes') {
              allNotes[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
              );
            } else if (state.collection == 'Favourites') {
              favourites[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
              );
            } else if (state.collection == 'Hidden') {
              hidden[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
              );
            } else {
              trash[widget.index!] = Note(
                title: updatedTitle,
                note: updatedNote,
                id: widget.note!.id,
                time: Timestamp.now(),
              );
            }

            Navigator.pop(context);
            Navigator.pop(context);

            // Show success or error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Note updated successfully',
                  style: TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          }

          if (state is NoteUpdateFail) {
            Navigator.pop(context);
            // Show success or error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Failed to update note',
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
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                widget.operation == 'newEvent'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.dayName?.isNotEmpty ?? false)
                                ? 'Event Date'
                                : 'Select Event Date',
                            style: TextStyle(
                              color: (widget.dayName?.isNotEmpty ?? false)
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.dayName ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ${widget.currentDay?.day ?? ''} ${widget.monthName ?? ''}'
                                '${(widget.monthName?.isNotEmpty ?? false) ? ',' : ''} '
                                '${widget.currentDay?.year ?? ''}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
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
