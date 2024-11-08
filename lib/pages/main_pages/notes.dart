import 'package:flutter/material.dart';
import 'package:textmarkt/pages/sub_pages/create_note.dart';
import 'package:textmarkt/search/search_bar.dart';
import 'package:textmarkt/widgets/note_section.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  String getMonthName(int monthNumber) {
    if (monthNumber == 1) {
      return "January";
    } else if (monthNumber == 2) {
      return "February";
    } else if (monthNumber == 3) {
      return "March";
    } else if (monthNumber == 4) {
      return "April";
    } else if (monthNumber == 5) {
      return "May";
    } else if (monthNumber == 6) {
      return "June";
    } else if (monthNumber == 7) {
      return "July";
    } else if (monthNumber == 8) {
      return "August";
    } else if (monthNumber == 9) {
      return "September";
    } else if (monthNumber == 10) {
      return "October";
    } else if (monthNumber == 11) {
      return "November";
    } else if (monthNumber == 12) {
      return "December";
    } else {
      return "Invalid month";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String monthName = getMonthName(today.month);
    double responsiveFontSize = MediaQuery.of(context).size.width * 0.05;

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
              builder: (context) => const CreateNote(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 15),
          MyearchBar(),
          SizedBox(height: 19),
          Padding(
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
          SizedBox(height: 10),
          Padding(
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
          SizedBox(height: 19),
          ////  notes here
        ],
      ),
    );
  }
}
