import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/features/search/pages/search_page.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/events/presentation/pages/events_page.dart';
import 'package:text_markt/features/notes/presentation/pages/notes_page.dart';
import 'package:text_markt/features/profile/presentation/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> screens = [
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: NotesPage(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: SearchPage(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: EventsPage(),
    ),
    const ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: ProfilePage(),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Colors fixed for both mobile and tablet
    Color backgroundColor = isDark
        ? Colors.grey.shade900
        : Colors.grey.shade400;
    Color iconColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
    Color activeColor = isDark ? Colors.grey[100]! : Colors.grey[800]!;
    Color tabBorderColor = isDark ? Colors.grey : Colors.white;

    double navPadding = isTablet ? 18 : 12;
    double tabBorderRadius = isTablet ? 28 : 20;
    double textFontSize = isTablet ? 16 : 13;
    double iconSize = isTablet ? 28 : 23;

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
