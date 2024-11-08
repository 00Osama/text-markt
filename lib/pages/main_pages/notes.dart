import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

  Future<List<Note>> getUserNotes() async {
    if (myNotes.isEmpty) {
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('allNotes')
          .get();
      myNotes = response.docs
          .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    }
    return myNotes;
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
          const MyearchBar(),
          const SizedBox(height: 19),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NoteSection(
                  icon: 'assets/images/allNotesSection.png',
                  iconBackGround: Color(0xff8E8E92),
                  section: 'All Notes',
                ),
                SizedBox(width: 10),
                NoteSection(
                  icon: 'assets/images/allNotesSection.png',
                  iconBackGround: Color(0xffF7CE45),
                  section: 'Favourites',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NoteSection(
                  icon: 'assets/images/hiddenSection.png',
                  iconBackGround: Color(0xff4E94F8),
                  section: 'Hidden',
                ),
                SizedBox(width: 10),
                NoteSection(
                  icon: 'assets/images/trashSection.png',
                  iconBackGround: Color(0xffEB4D3D),
                  section: 'Trash',
                ),
              ],
            ),
          ),
          const SizedBox(height: 19),
          FutureBuilder<List<Note>>(
            future: getUserNotes(),
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
