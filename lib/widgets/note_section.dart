import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: isTablet ? 80 : 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(isTablet ? 17 : 12),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              CircleAvatar(
                backgroundColor: iconColor,
                radius: isTablet ? screenWidth * 0.03 : screenWidth * 0.05,
                child: sectionName == 'All Notes'
                    ? Image.asset(
                        'assets/images/allNotesSection.png',
                        width: isTablet
                            ? screenWidth * 0.03
                            : screenWidth * 0.05,
                        height: isTablet
                            ? screenWidth * 0.03
                            : screenWidth * 0.05,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        sectionIcon,
                        color: Colors.white,
                        size: isTablet
                            ? screenWidth * 0.03
                            : screenWidth * 0.05,
                      ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                sectionName == 'All Notes'
                    ? S.of(context).allNotes
                    : sectionName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
