import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class Swipeitem extends StatelessWidget {
  const Swipeitem({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/swipeItem.png',
          width: isTablet ? 42 : 21,
          height: isTablet ? 42 : 21,
          fit: BoxFit.fill,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black.withOpacity(0.5)
              : Colors.white.withOpacity(0.5),
        ),
        SizedBox(width: isTablet ? 10 : 5),
        Text(
          S.of(context).swipeForMoreOptions,
          style: TextStyle(
            fontSize: isTablet ? 45 : 15,
            color:
                Theme.of(context).textTheme.bodySmall?.color ??
                Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
