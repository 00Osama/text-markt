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
  final List<Widget> screens = [
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Colors fixed for both mobile and tablet
    Color backgroundColor = isDark
        ? Colors.grey.shade900
        : Colors.grey.shade400;
    Color iconColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
    Color activeColor = isDark ? Colors.grey[100]! : Colors.grey[800]!;
    Color tabBorderColor = isDark ? Colors.grey : Colors.white;

    // Responsive sizes
    double navPadding = screenWidth < 600 ? 15 : 30; // bigger on tablet
    double tabBorderRadius = screenWidth < 600 ? 20 : 35; // bigger on tablet
    double textFontSize = screenWidth < 600 ? 14 : 37; // bigger on tablet
    double iconSize = screenWidth < 600 ? 24 : 33; // bigger on tablet

    return Scaffold(
      backgroundColor: backgroundColor,
      body: screens[_selectedIndex],
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: backgroundColor,
        color: iconColor,
        activeColor: activeColor,
        tabActiveBorder: Border.all(color: tabBorderColor),
        tabBorderRadius: tabBorderRadius,
        padding: EdgeInsets.all(navPadding),
        tabs: [
          GButton(
            icon: Icons.note_alt_outlined,
            iconSize: iconSize,
            text: ' ${S.of(context).notesTitle}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
          GButton(
            icon: Icons.search,
            iconSize: iconSize,
            text: ' ${S.of(context).searchTitle}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
          GButton(
            icon: Icons.event,
            iconSize: iconSize,
            text: ' ${S.of(context).eventsTitle}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
          GButton(
            icon: Icons.person_outline_rounded,
            iconSize: iconSize,
            text: ' ${S.of(context).profileTitle}',
            textStyle: TextStyle(fontSize: textFontSize),
            margin: EdgeInsets.symmetric(vertical: navPadding / 2),
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
