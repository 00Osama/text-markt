import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/bloc/note_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/models/note.dart';
import 'package:text_markt/pages/sub_pages/create_or_update_note.dart';
import 'package:text_markt/search/search_bar.dart';
import 'package:text_markt/widgets/note_section.dart';
import 'package:text_markt/widgets/notes_builder.dart';

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
      "December",
    ];
    return (monthNumber >= 1 && monthNumber <= 12)
        ? monthNames[monthNumber]
        : "Invalid month";
  }

  String getCollectionName(String newCollection) {
    switch (newCollection) {
      case 'AllNotes':
        return S.of(context).allNotes;
      case 'Favourites':
        return S.of(context).noteAddedToFavorites;
      case 'Hidden':
        return S.of(context).noteAddedToHidden;
      case 'Trash':
        return S.of(context).noteAddedToTrash;
      default:
        return '';
    }
  }

  ////////////////////////////
  Future<List<Note>> getNotes(String notes) async {
    if (notes == 'AllNotes') {
      if (allNotes.isEmpty) {
        QuerySnapshot response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(notes)
            .orderBy('time', descending: true)
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
            .orderBy('time', descending: true)
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
            .orderBy('time', descending: true)
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
            .orderBy('time', descending: true)
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
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat(
                    'EEEE, d MMMM y',
                    Localizations.localeOf(context).toLanguageTag(),
                  ).format(DateTime.now()),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  S.of(context).Notes,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.backgroundColor,
        foregroundColor: Theme.of(
          context,
        ).floatingActionButtonTheme.foregroundColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateOrUpdateNote(operation: 'add'),
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
                      sectionName: S.of(context).favorites,
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
                      sectionName: S.of(context).hidden,
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
                      sectionName: S.of(context).trash,
                      onPressed: () {
                        context.read<NoteCubit>().switchNotes('Trash');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocConsumer<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is NoteMovedSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      getCollectionName(state.newCollection),
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
                    content: Text(
                      S.of(context).noteDeletedSuccessfully,
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
              }
              if (state is NoteDeleteFail) {
                // Show success or error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context).failedToDeleteNote,
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
            },
            builder: (context, state) {
              late final String currentState;

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

              print(
                'BlocBuilder Current State ::::::::::::::::: $currentState',
              );

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
                            style: Theme.of(context).textTheme.bodyMedium,
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
                            S.of(context).noNotes,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: NotesBuilder(
                      notes: snapshot.data!,
                      currentCollection: currentState,
                      pin: '1111',
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
