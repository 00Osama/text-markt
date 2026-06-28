import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/profile/domain/entities/user_profile.dart';

UserProfile? user;
List<Note> allNotes = [];
List<Note> favourites = [];
List<Note> hidden = [];
List<Note> trash = [];
List<Event> events = [];
String? hiddenNotesPin;
