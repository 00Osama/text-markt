import 'package:flutter/material.dart';
import 'package:textmarkt/pages/create_note.dart';
import 'package:textmarkt/pages/events.dart';
import 'package:textmarkt/pages/notes.dart';
import 'package:textmarkt/pages/search.dart';

class AppController extends StatefulWidget {
  const AppController({super.key});

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  List screens = [
    const Notes(),
    const Events(),
    const Search(),
    const CreateNote(),
  ];
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        selectedItemColor: const Color(0xff007AFF),
        unselectedItemColor: const Color(0xff1C2121),
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffF9F9F9),
            icon: Image.asset(
              'assets/images/bottomNotes.png',
              color: const Color(0xff1C2121),
            ),
            activeIcon: Image.asset(
              'assets/images/bottomNotes.png',
              color: const Color(0xff007AFF),
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/bottomEvents.png',
              color: const Color(0xff1C2121),
            ),
            activeIcon: Image.asset(
              'assets/images/bottomEvents.png',
              color: const Color(0xff007AFF),
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/bottomSearch.png',
              color: const Color(0xff1C2121),
            ),
            activeIcon: Image.asset(
              'assets/images/bottomSearch.png',
              color: const Color(0xff007AFF),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/bottomCreateNotes.png',
              color: const Color(0xff1C2121),
            ),
            activeIcon: Image.asset(
              'assets/images/bottomCreateNotes.png',
              color: const Color(0xff007AFF),
            ),
            label: 'Create Note',
          ),
        ],
      ),
    );
  }
}
