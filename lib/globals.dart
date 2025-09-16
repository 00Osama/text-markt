import 'package:text_markt/models/event.dart';
import 'package:text_markt/models/note.dart';
import 'package:text_markt/models/user.dart';

UserInfoData? user;
List<Note> allNotes = [];
List<Note> favourites = [];
List<Note> hidden = [];
List<Note> trash = [];
List<Event> events = [];
String? hiddenNotesPin;
