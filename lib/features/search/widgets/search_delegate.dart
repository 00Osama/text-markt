import 'package:flutter/material.dart';
import 'package:text_markt/core/dependency_injection/service_locator.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/search/widgets/search_controller.dart';

class Searchdelegate extends SearchDelegate<String?> {
  Future<List<Note>> getNotes(String collection) async {
    List<Note> notes;

    if (collection == 'AllNotes') {
      notes = allNotes;
    } else if (collection == 'Favourites') {
      notes = favourites;
    } else if (collection == 'Hidden') {
      notes = hidden;
    } else {
      notes = trash;
    }

    if (notes.isNotEmpty) return notes;

    notes = await ServiceLocator.getNotesUseCase(collection);

    if (collection == 'AllNotes') {
      allNotes = notes;
    } else if (collection == 'Favourites') {
      favourites = notes;
    } else if (collection == 'Hidden') {
      hidden = notes;
    } else {
      trash = notes;
    }

    return notes;
  }

  final ValueNotifier<String> selectedCollection = ValueNotifier('AllNotes');
  String? recordedQuery = '';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StatefulBuilder(
        builder: (context, setState) {
          return DropdownButton<String>(
            dropdownColor: Theme.of(
              context,
            ).floatingActionButtonTheme.backgroundColor,
            value: selectedCollection.value,
            items: [
              DropdownMenuItem<String>(
                value: 'AllNotes',
                child: Text(
                  S.of(context).allNotes,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem<String>(
                value: 'Favourites',
                child: Text(
                  S.of(context).favorites,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem<String>(
                value: 'Hidden',
                child: Text(
                  S.of(context).hidden,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem<String>(
                value: 'Trash',
                child: Text(
                  S.of(context).trash,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedCollection.value = value;
                  query = '';
                });
                showSuggestions(context);
              }
            },
            hint: const Text('All Notes'),
          );
        },
      ),
      Tooltip(
        message: S().clearQueryAndExit,
        child: IconButton(
          onPressed: () {
            if (query == '') {
              Navigator.pop(context);
            }
            query = '';
          },
          icon: const Icon(Icons.cancel),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Tooltip(
      message: S().saveQueryToSearchHistory,
      child: IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Padding(
          padding: EdgeInsets.all(17),
          child: Icon(Icons.save_rounded),
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    recordedQuery = query;

    return ValueListenableBuilder<String>(
      valueListenable: selectedCollection,
      builder: (context, collection, _) {
        return FutureBuilder<List<Note>>(
          future: getNotes(collection),
          builder: (context, snapshot) {
            List<Note> filteredNotes = snapshot.data ?? [];

            if (query.isNotEmpty) {
              filteredNotes = filteredNotes
                  .where(
                    (note) =>
                        note.title.contains(query) || note.note.contains(query),
                  )
                  .toList();
            }

            return MySearchController(
              key: ValueKey('$collection-${recordedQuery!.trim()}'),
              query: recordedQuery!.trim(),
              currentCollection: collection,
              notes: filteredNotes,
            );
          },
        );
      },
    );
  }

  @override
  void close(BuildContext context, result) {
    super.close(context, query.trim());
  }

  @override
  void dispose() {
    selectedCollection.dispose();
    super.dispose();
  }
}
