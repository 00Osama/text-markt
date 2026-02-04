import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class Swipeitem extends StatelessWidget {
  const Swipeitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/swipeItem.png',
          width: 21,
          height: 21,
          fit: BoxFit.fill,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black.withOpacity(0.5)
              : Colors.white.withOpacity(0.5),
        ),
        const SizedBox(width: 5),
        Text(
          S.of(context).swipeForMoreOptions,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
