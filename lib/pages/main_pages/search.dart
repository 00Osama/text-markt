import 'package:flutter/material.dart';
import 'package:textmarkt/search/search_bar.dart';
import 'package:textmarkt/search/recent_searches.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            MyearchBar(),
            RecentSearches(),
          ],
        ),
      ),
    );
  }
}
