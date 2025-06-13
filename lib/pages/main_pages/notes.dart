import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:textmarkt/bloc/note_cubit.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/note.dart';
import 'package:textmarkt/pages/sub_pages/create_or_update_note.dart';
import 'package:textmarkt/search/search_bar.dart';
import 'package:textmarkt/widgets/note_section.dart';
import 'package:textmarkt/widgets/notes_builder.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  String getMonthName(int monthNumber) {
    const monthNames = [
      "Invalid month",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return (monthNumber >= 1 && monthNumber <= 12)
        ? monthNames[monthNumber]
        : "Invalid month";
  }

  ////////////////////////////
  Future<List<Note>> getNotes(String notes) async {
    if (notes == 'AllNotes') {
      if (allNotes.isEmpty) {
        QuerySnapshot response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(notes)
            .orderBy(
              'time',
              descending: true,
            )
            .get();

        allNotes = response.docs.map((doc) {
          var note = Note.fromJson(doc.data() as Map<String, dynamic>);
          note.id = doc.id;
          return note;
        }).toList();
      }
      return allNotes;
    } else if (notes == 'Favourites') {
      if (favourites.isEmpty) {
        QuerySnapshot response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(notes)
            .orderBy(
              'time',
              descending: true,
            )
            .get();
        favourites = response.docs.map((doc) {
          var note = Note.fromJson(doc.data() as Map<String, dynamic>);
          note.id = doc.id;
          return note;
        }).toList();
      }
      return favourites;
    } else if (notes == 'Hidden') {
      if (hidden.isEmpty) {
        QuerySnapshot response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(notes)
            .orderBy(
              'time',
              descending: true,
            )
            .get();
        hidden = response.docs.map((doc) {
          var note = Note.fromJson(doc.data() as Map<String, dynamic>);
          note.id = doc.id;
          return note;
        }).toList();
      }
      return hidden;
    } else {
      if (trash.isEmpty) {
        QuerySnapshot response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(notes)
            .orderBy(
              'time',
              descending: true,
            )
            .get();
        trash = response.docs.map((doc) {
          var note = Note.fromJson(doc.data() as Map<String, dynamic>);
          note.id = doc.id;
          return note;
        }).toList();
      }
      return trash;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String monthName = getMonthName(today.month);
    double responsiveFontSize = MediaQuery.of(context).size.width * 0.05;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  '${today.day} $monthName, ${today.year}',
                  style: TextStyle(
                    fontSize: responsiveFontSize,
                    color: const Color.fromARGB(178, 60, 60, 67),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateOrUpdateNote(
                operation: 'add',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          const MySearchBar(),
          const SizedBox(height: 19),
          BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NoteSection(
                      sectionIcon: FontAwesomeIcons.heart,
                      iconColor: const Color(0xff8E8E92),
                      borderColor: state is AllNotes
                          ? const Color(0xff8E8E92)
                          : Colors.transparent,
                      sectionName: 'All Notes',
                      onPressed: () {
                        context.read<NoteCubit>().switchNotes('AllNotes');
                      },
                    ),
                    const SizedBox(width: 10),
                    NoteSection(
                      sectionIcon: FontAwesomeIcons.heart,
                      iconColor: const Color(0xffF7CE45),
                      borderColor: state is Favourites
                          ? const Color(0xffF7CE45)
                          : Colors.transparent,
                      sectionName: 'Favourites',
                      onPressed: () {
                        context.read<NoteCubit>().switchNotes('Favourites');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NoteSection(
                      sectionIcon: FontAwesomeIcons.eyeSlash,
                      iconColor: const Color(0xff4E94F8),
                      borderColor: state is Hidden
                          ? const Color(0xff4E94F8)
                          : Colors.transparent,
                      sectionName: 'Hidden',
                      onPressed: () {
                        context.read<NoteCubit>().switchNotes('Hidden');
                      },
                    ),
                    const SizedBox(width: 10),
                    NoteSection(
                      sectionIcon: FontAwesomeIcons.trashCan,
                      iconColor: const Color(0xffEB4D3D),
                      borderColor: state is Trash
                          ? const Color(0xffEB4D3D)
                          : Colors.transparent,
                      sectionName: 'Trash',
                      onPressed: () {
                        context.read<NoteCubit>().switchNotes('Trash');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 19),
          BlocConsumer<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is NoteMovedSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Note added to ${state.newCollection} successfully',
                      style: const TextStyle(color: Colors.white),
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

                if (state.oldCollection == 'AllNotes') {
                  allNotes.removeAt(state.index);
                } else if (state.oldCollection == 'Favourites') {
                  favourites.removeAt(state.index);
                } else if (state.oldCollection == 'Hidden') {
                  hidden.removeAt(state.index);
                }
                if (state.newCollection == 'Favourites') {
                  favourites.insert(
                    0,
                    Note(
                      title: state.title,
                      note: state.note,
                      time: Timestamp.now(),
                      id: state.id,
                    ),
                  );
                }
                if (state.newCollection == 'Hidden') {
                  hidden.insert(
                    0,
                    Note(
                      title: state.title,
                      note: state.note,
                      time: Timestamp.now(),
                      id: state.id,
                    ),
                  );
                }
                if (state.newCollection == 'Trash') {
                  trash.insert(
                    0,
                    Note(
                      title: state.title,
                      note: state.note,
                      time: Timestamp.now(),
                      id: state.id,
                    ),
                  );
                }
              }
              if (state is NoteMovedFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'failed to add note to ${state.collection}',
                      style: const TextStyle(color: Colors.white),
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
              if (state is NoteDeleteSuccess) {
                trash.removeAt(state.index);
                // Show success or error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Note deleted successfully',
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
              if (state is NoteDeleteFail) {
                // Show success or error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'failed to delete note',
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
            builder: (context, state) {
              String? currentState;
              if (state is AllNotes) {
                currentState = 'AllNotes';
              } else if (state is Favourites) {
                currentState = 'Favourites';
              } else if (state is Hidden) {
                currentState = 'Hidden';
              } else if (state is Trash) {
                currentState = 'Trash';
              } else {
                currentState = 'AllNotes';
              }

              if (state is NoteMovedLoading) {
                return Expanded(
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      LoadingAnimationWidget.threeRotatingDots(
                        color: const Color.fromARGB(255, 67, 143, 224),
                        size: 90,
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                );
              }

              return FutureBuilder<List<Note>>(
                future: getNotes(currentState),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          LoadingAnimationWidget.threeRotatingDots(
                            color: const Color.fromARGB(255, 67, 143, 224),
                            size: 90,
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          Image.asset(
                            'assets/images/error.png',
                            width: screenHeight * 0.5,
                            height: screenHeight * 0.25,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Text(
                            'Unexpected error occurred',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          Image.asset(
                            'assets/images/no.png',
                            width: screenHeight * 0.5,
                            height: screenHeight * 0.25,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'No notes found',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: NotesBuilder(
                      notes: snapshot.data!,
                      currentCollection: currentState!,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
