import 'package:flutter/material.dart';

class NoteSection extends StatelessWidget {
  const NoteSection({
    super.key,
    required this.sectionIcon,
    required this.sectionName,
    required this.iconColor,
    required this.onPressed,
    required this.borderColor,
  });

  final Color iconColor;
  final Color borderColor;
  final String sectionName;
  final IconData sectionIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: iconColor,
                child: sectionName == 'All Notes'
                    ? Image.asset('assets/images/allNotesSection.png')
                    : Icon(
                        sectionIcon,
                        color: Colors.white,
                        size: 18,
                      ),
              ),
              const SizedBox(width: 7),
              Text(sectionName),
            ],
          ),
        ),
      ),
    );
  }
}
