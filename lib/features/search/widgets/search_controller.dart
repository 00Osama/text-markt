import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/presentation/widgets/notes_builder.dart';

class MySearchController extends StatefulWidget {
  const MySearchController({
    super.key,
    required this.query,
    required this.notes,
    required this.currentCollection,
  });

  final String query;
  final List<Note> notes;
  final String currentCollection;

  @override
  State<MySearchController> createState() => _MySearchControllerState();
}

class _MySearchControllerState extends State<MySearchController> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: widget.notes.isEmpty
          ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Image.asset(
                    'assets/images/no.png',
                    width: screenHeight * 0.5,
                    height: screenHeight * 0.25,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    S.of(context).noNotes,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            )
          : NotesBuilder(
              notes: widget.notes,
              currentCollection: widget.currentCollection,
              searchQuery: widget.query,
            ),
    );
  }
}
