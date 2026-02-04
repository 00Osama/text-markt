import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/models/note.dart';
import 'package:text_markt/search/search_controller.dart';

class Searchdelegate extends SearchDelegate {
  String myValue = 'AllNotes';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      DropdownButton<String>(
        value: myValue,
        items: [
          DropdownMenuItem<String>(
            value: 'AllNotes',
            child: Text(S.of(context).allNotes),
          ),
          DropdownMenuItem<String>(
            value: 'Favourites',
            child: Text(S.of(context).favorites),
          ),
          DropdownMenuItem<String>(
            value: 'Hidden',
            child: Text(S.of(context).hidden),
          ),
          DropdownMenuItem<String>(
            value: 'Trash',
            child: Text(S.of(context).trash),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            myValue = value;
            query = '';
            showSuggestions(context);
          }
        },
        hint: const Text('All Notes'),
      ),
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.cancel),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: const Padding(
        padding: EdgeInsets.all(17),
        child: Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Note> filteredNotes = [];

    if (myValue == 'AllNotes') {
      filteredNotes = allNotes;
    } else if (myValue == 'Favourites') {
      filteredNotes = favourites;
    } else if (myValue == 'Hidden') {
      filteredNotes = hidden;
    } else if (myValue == 'Trash') {
      filteredNotes = trash;
    }

    if (query.isNotEmpty) {
      filteredNotes = filteredNotes
          .where(
            (note) => note.title.contains(query) || note.note.contains(query),
          )
          .toList();
    }

    return MySearchController(
      query: query.trim(),
      currentCollection: myValue,
      notes: filteredNotes,
    );
  }
}
