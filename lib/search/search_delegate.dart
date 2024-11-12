import 'package:flutter/material.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/search/search_controller.dart';
import 'package:textmarkt/models/note.dart';

class Searchdelegate extends SearchDelegate {
  String myValue = 'AllNotes';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // Dropdown to filter notes by collection
      DropdownButton<String>(
        value: myValue,
        items: const [
          DropdownMenuItem<String>(
            value: 'AllNotes',
            child: Text('All Notes'),
          ),
          DropdownMenuItem<String>(
            value: 'Favourites',
            child: Text('Favourites'),
          ),
          DropdownMenuItem<String>(
            value: 'Hidden',
            child: Text('Hidden'),
          ),
          DropdownMenuItem<String>(
            value: 'Trash',
            child: Text('Trash'),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            myValue = value;
            query = ''; // Optional: Clear query when switching categories
            showSuggestions(context); // Refresh the suggestions
          }
        },
        hint: const Text('All Notes'),
      ),
      // Clear the query when the cancel icon is pressed
      IconButton(
        onPressed: () {
          query = ''; // Clear the search query
        },
        icon: const Icon(Icons.cancel),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null); // Close search when back is pressed
      },
      child: const Padding(
        padding: EdgeInsets.all(17),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text(''); // You can customize this to show search results.
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Filter notes based on the selected collection
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

    // Filter the list based on the search query
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
