import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textmarkt/models/note.dart';

class CreateOrUpdateNote extends StatefulWidget {
  const CreateOrUpdateNote({
    super.key,
    required this.operation,
    this.note,
  });

  final String operation;
  final Note? note;

  @override
  State<CreateOrUpdateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateOrUpdateNote> {
  final TextEditingController? titleController = TextEditingController();
  final TextEditingController? noteController = TextEditingController();

  @override
  void initState() {
    if (widget.operation == 'update') {
      titleController!.text = widget.note?.title ?? '';
      noteController!.text = widget.note?.note ?? '';
    }
    super.initState();
  }

  void addNote() async {
    if (titleController!.text.trim().isEmpty &&
        noteController!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'enter at least a note title',
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
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('allNotes')
            .add(
          {
            'title': titleController == null ? '' : titleController!.text,
            'note': noteController == null ? '' : noteController!.text,
            'time': Timestamp.now(),
          },
        );

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Note added successfully',
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

        if (titleController!.text.isNotEmpty) {
          titleController!.clear();
        }
        if (noteController!.text.isNotEmpty) {
          noteController!.clear();
        }
      } on Exception {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to add note',
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
    }
  }

  updateNote() {}

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
              backgroundColor: const WidgetStatePropertyAll(
                Color(0xff1F2124),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            onPressed: widget.operation == 'add' ? addNote : updateNote,
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
      body: SingleChildScrollView(
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
                  decorationColor: Colors.red,
                  decorationThickness: 2,
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
    );
  }
}
