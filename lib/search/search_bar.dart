import 'package:flutter/material.dart';
import 'package:textmarkt/search/search_delegate.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: Searchdelegate(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(flex: 1),
              Text(
                'Search',
                style: TextStyle(
                  color: Color(0xff1C2121),
                  fontSize: 14,
                ),
              ),
              Spacer(flex: 30),
            ],
          ),
        ),
      ),
    );
  }
}
