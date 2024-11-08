import 'package:flutter/material.dart';

class NoteSection extends StatelessWidget {
  const NoteSection({
    super.key,
    required this.icon,
    required this.section,
    required this.iconBackGround,
  });

  final String icon;
  final Color iconBackGround;
  final String section;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            CircleAvatar(
              backgroundColor: iconBackGround,
              child: Image.asset(icon),
            ),
            const SizedBox(width: 7),
            Text(section),
          ],
        ),
      ),
    );
  }
}
