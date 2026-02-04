import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/search/search_delegate.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: Searchdelegate());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 1),
              Text(
                S.of(context).searchTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(flex: 30),
            ],
          ),
        ),
      ),
    );
  }
}
