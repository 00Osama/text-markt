// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Notes`
  String get notesTitle {
    return Intl.message('Notes', name: 'notesTitle', desc: '', args: []);
  }

  /// `Search`
  String get searchTitle {
    return Intl.message('Search', name: 'searchTitle', desc: '', args: []);
  }

  /// `Events`
  String get eventsTitle {
    return Intl.message('Events', name: 'eventsTitle', desc: '', args: []);
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `New Note`
  String get newNote {
    return Intl.message('New Note', name: 'newNote', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Note`
  String get Note {
    return Intl.message('Note', name: 'Note', desc: '', args: []);
  }

  /// `Notes`
  String get Notes {
    return Intl.message('Notes', name: 'Notes', desc: '', args: []);
  }

  /// `Update Note`
  String get updateNote {
    return Intl.message('Update Note', name: 'updateNote', desc: '', args: []);
  }

  /// `All Notes`
  String get allNotes {
    return Intl.message('All Notes', name: 'allNotes', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Hidden`
  String get hidden {
    return Intl.message('Hidden', name: 'hidden', desc: '', args: []);
  }

  /// `Trash`
  String get trash {
    return Intl.message('Trash', name: 'trash', desc: '', args: []);
  }

  /// `enter at least note title`
  String get enterAtLeastNoteTitle {
    return Intl.message(
      'enter at least note title',
      name: 'enterAtLeastNoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Note added successfully`
  String get noteAddedSuccessfully {
    return Intl.message(
      'Note added successfully',
      name: 'noteAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add note`
  String get failedToAddNote {
    return Intl.message(
      'Failed to add note',
      name: 'failedToAddNote',
      desc: '',
      args: [],
    );
  }

  /// `Note updated successfully`
  String get noteUpdatedSuccessfully {
    return Intl.message(
      'Note updated successfully',
      name: 'noteUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update note`
  String get failedToUpdateNote {
    return Intl.message(
      'Failed to update note',
      name: 'failedToUpdateNote',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get areYouSureYouWantToSignOut {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'areYouSureYouWantToSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message('Theme Mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Light`
  String get lightMode {
    return Intl.message('Light', name: 'lightMode', desc: '', args: []);
  }

  /// `Dark`
  String get darkMode {
    return Intl.message('Dark', name: 'darkMode', desc: '', args: []);
  }

  /// `System`
  String get systemMode {
    return Intl.message('System', name: 'systemMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Recent Searches`
  String get recentSearches {
    return Intl.message(
      'Recent Searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `No recent searches found.`
  String get noRecentSearches {
    return Intl.message(
      'No recent searches found.',
      name: 'noRecentSearches',
      desc: '',
      args: [],
    );
  }

  /// `New Event`
  String get newEvent {
    return Intl.message('New Event', name: 'newEvent', desc: '', args: []);
  }

  /// `Title`
  String get Title {
    return Intl.message('Title', name: 'Title', desc: '', args: []);
  }

  /// `title`
  String get TitleHint {
    return Intl.message('title', name: 'TitleHint', desc: '', args: []);
  }

  /// `Event`
  String get Event {
    return Intl.message('Event', name: 'Event', desc: '', args: []);
  }

  /// `event`
  String get EventHint {
    return Intl.message('event', name: 'EventHint', desc: '', args: []);
  }

  /// `Date`
  String get Date {
    return Intl.message('Date', name: 'Date', desc: '', args: []);
  }

  /// `Time`
  String get Time {
    return Intl.message('Time', name: 'Time', desc: '', args: []);
  }

  /// `Please fill all fields before uploading.`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields before uploading.',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Event added successfully`
  String get eventAddedSuccessfully {
    return Intl.message(
      'Event added successfully',
      name: 'eventAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Note deleted successfully`
  String get noteDeletedSuccessfully {
    return Intl.message(
      'Note deleted successfully',
      name: 'noteDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add event`
  String get failedToAddEvent {
    return Intl.message(
      'Failed to add event',
      name: 'failedToAddEvent',
      desc: '',
      args: [],
    );
  }

  /// `Event deleted successfully`
  String get eventDeletedSuccessfully {
    return Intl.message(
      'Event deleted successfully',
      name: 'eventDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No events found`
  String get noEvents {
    return Intl.message(
      'No events found',
      name: 'noEvents',
      desc: '',
      args: [],
    );
  }

  /// `No notes found`
  String get noNotes {
    return Intl.message('No notes found', name: 'noNotes', desc: '', args: []);
  }

  /// `Event Preview`
  String get eventPreview {
    return Intl.message(
      'Event Preview',
      name: 'eventPreview',
      desc: '',
      args: [],
    );
  }

  /// `Move to Trash`
  String get moveToTrash {
    return Intl.message(
      'Move to Trash',
      name: 'moveToTrash',
      desc: '',
      args: [],
    );
  }

  /// `Delete Event`
  String get deleteEvent {
    return Intl.message(
      'Delete Event',
      name: 'deleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Add To Hide`
  String get addToHidden {
    return Intl.message('Add To Hide', name: 'addToHidden', desc: '', args: []);
  }

  /// `Add To Favorites`
  String get addToFavorites {
    return Intl.message(
      'Add To Favorites',
      name: 'addToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Permanently Delete`
  String get permanentlyDelete {
    return Intl.message(
      'Permanently Delete',
      name: 'permanentlyDelete',
      desc: '',
      args: [],
    );
  }

  /// `Note added to trash successfully`
  String get noteAddedToTrash {
    return Intl.message(
      'Note added to trash successfully',
      name: 'noteAddedToTrash',
      desc: '',
      args: [],
    );
  }

  /// `Note added to hidden successfully`
  String get noteAddedToHidden {
    return Intl.message(
      'Note added to hidden successfully',
      name: 'noteAddedToHidden',
      desc: '',
      args: [],
    );
  }

  /// `Note added to favorites successfully`
  String get noteAddedToFavorites {
    return Intl.message(
      'Note added to favorites successfully',
      name: 'noteAddedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete note`
  String get failedToDeleteNote {
    return Intl.message(
      'Failed to delete note',
      name: 'failedToDeleteNote',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
