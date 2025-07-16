import 'package:flutter/material.dart';
import 'package:textmarkt/generated/l10n.dart';
import 'package:textmarkt/search/search_bar.dart';
import 'package:textmarkt/search/recent_searches.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          S.of(context).searchTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            MySearchBar(),
            RecentSearches(),
          ],
        ),
      ),
    );
  }
}
