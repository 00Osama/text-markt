import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/pages/main_pages/events.dart';
import 'package:text_markt/pages/main_pages/notes.dart';
import 'package:text_markt/pages/main_pages/profile.dart';
import 'package:text_markt/pages/main_pages/search.dart';

class AppController extends StatefulWidget {
  const AppController({super.key});

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  List screens = [
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Notes(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Search(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Events(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Profile(),
    ),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade900
          : Colors.grey.shade400,
      body: screens[_selectedIndex],
      bottomNavigationBar: screenWidth < 600
          ? GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade900
                  : Colors.grey.shade400,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]
                  : Colors.grey[500],
              activeColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[100]
                  : Colors.grey[800],
              tabActiveBorder: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Colors.white,
              ),
              tabBorderRadius: 20,
              padding: const EdgeInsets.all(15),
              tabs: [
                GButton(
                  icon: Icons.note_alt_outlined,
                  text: ' ${S.of(context).notesTitle}',
                  textStyle: const TextStyle(fontSize: 14),
                  margin: const EdgeInsets.symmetric(vertical: 9),
                ),
                GButton(
                  icon: Icons.search,
                  text: ' ${S.of(context).searchTitle}',
                  textStyle: const TextStyle(fontSize: 14),
                  margin: const EdgeInsets.symmetric(vertical: 9),
                ),
                GButton(
                  icon: Icons.event,
                  text: ' ${S.of(context).eventsTitle}',
                  textStyle: const TextStyle(fontSize: 14),
                  margin: const EdgeInsets.symmetric(vertical: 9),
                ),
                GButton(
                  icon: Icons.person_outline_rounded,
                  text: ' ${S.of(context).profileTitle}',
                  textStyle: const TextStyle(fontSize: 14),
                  margin: const EdgeInsets.symmetric(vertical: 9),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
          : BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedItemColor: const Color(0xff007AFF),
              unselectedItemColor: const Color(0xff1C2121),
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.note_alt_outlined),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}
