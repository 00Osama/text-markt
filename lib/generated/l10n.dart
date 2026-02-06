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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Are you sure you want to sign out ?!`
  String get areYouSureYouWantToSignOut {
    return Intl.message(
      'Are you sure you want to sign out ?!',
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

  /// `Swipe for more options`
  String get swipeForMoreOptions {
    return Intl.message(
      'Swipe for more options',
      name: 'swipeForMoreOptions',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get french {
    return Intl.message('French', name: 'french', desc: '', args: []);
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN`
  String get pin {
    return Intl.message('Enter PIN', name: 'pin', desc: '', args: []);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Don't have an account ?! `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account ?! ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?! `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account ?! ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Manage your`
  String get onboarding1TitleLine1 {
    return Intl.message(
      'Manage your',
      name: 'onboarding1TitleLine1',
      desc: '',
      args: [],
    );
  }

  /// `notes easily`
  String get onboarding1TitleLine2 {
    return Intl.message(
      'notes easily',
      name: 'onboarding1TitleLine2',
      desc: '',
      args: [],
    );
  }

  /// `A completely easy way to manage and customize your notes.`
  String get onboarding1Description {
    return Intl.message(
      'A completely easy way to manage and customize your notes.',
      name: 'onboarding1Description',
      desc: '',
      args: [],
    );
  }

  /// `Organize your`
  String get onboarding2TitleLine1 {
    return Intl.message(
      'Organize your',
      name: 'onboarding2TitleLine1',
      desc: '',
      args: [],
    );
  }

  /// `thoughts`
  String get onboarding2TitleLine2 {
    return Intl.message(
      'thoughts',
      name: 'onboarding2TitleLine2',
      desc: '',
      args: [],
    );
  }

  /// `Most beautiful note-taking application.`
  String get onboarding2Description {
    return Intl.message(
      'Most beautiful note-taking application.',
      name: 'onboarding2Description',
      desc: '',
      args: [],
    );
  }

  /// `Create cards and`
  String get onboarding3TitleLine1 {
    return Intl.message(
      'Create cards and',
      name: 'onboarding3TitleLine1',
      desc: '',
      args: [],
    );
  }

  /// `easy styling`
  String get onboarding3TitleLine2 {
    return Intl.message(
      'easy styling',
      name: 'onboarding3TitleLine2',
      desc: '',
      args: [],
    );
  }

  /// `Making your content legible has never been easier.`
  String get onboarding3Description {
    return Intl.message(
      'Making your content legible has never been easier.',
      name: 'onboarding3Description',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 7 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 7 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Username must be at least 4 characters`
  String get usernameMinLength {
    return Intl.message(
      'Username must be at least 4 characters',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwordsNotMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwordsNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Valid sign in`
  String get validSignin {
    return Intl.message(
      'Valid sign in',
      name: 'validSignin',
      desc: '',
      args: [],
    );
  }

  /// `Invalid sign in`
  String get invalidSignin {
    return Intl.message(
      'Invalid sign in',
      name: 'invalidSignin',
      desc: '',
      args: [],
    );
  }

  /// `Valid sign up`
  String get validSignup {
    return Intl.message(
      'Valid sign up',
      name: 'validSignup',
      desc: '',
      args: [],
    );
  }

  /// `Invalid sign up`
  String get invalidSignup {
    return Intl.message(
      'Invalid sign up',
      name: 'invalidSignup',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type your email address`
  String get typeYourEmail {
    return Intl.message(
      'Type your email address',
      name: 'typeYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `We will send a password reset link for you.`
  String get resetPasswordHint {
    return Intl.message(
      'We will send a password reset link for you.',
      name: 'resetPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Link`
  String get sendLink {
    return Intl.message('Send Link', name: 'sendLink', desc: '', args: []);
  }

  /// `Success`
  String get successTitle {
    return Intl.message('Success', name: 'successTitle', desc: '', args: []);
  }

  /// `Password reset link sent! Check your email.`
  String get resetLinkSent {
    return Intl.message(
      'Password reset link sent! Check your email.',
      name: 'resetLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmailTitle {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `We sent a verification link to verify your account.`
  String get verificationHint {
    return Intl.message(
      'We sent a verification link to verify your account.',
      name: 'verificationHint',
      desc: '',
      args: [],
    );
  }

  /// `Re-send Email`
  String get resendEmail {
    return Intl.message(
      'Re-send Email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Re-send in {seconds} seconds`
  String resendInSeconds(Object seconds) {
    return Intl.message(
      'Re-send in $seconds seconds',
      name: 'resendInSeconds',
      desc: '',
      args: [seconds],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message('Error', name: 'errorTitle', desc: '', args: []);
  }

  /// `Try again later`
  String get tryAgainLater {
    return Intl.message(
      'Try again later',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `PIN set successfully`
  String get pinSuccessfullySet {
    return Intl.message(
      'PIN set successfully',
      name: 'pinSuccessfullySet',
      desc: '',
      args: [],
    );
  }

  /// `Failed to set PIN`
  String get pinError {
    return Intl.message(
      'Failed to set PIN',
      name: 'pinError',
      desc: '',
      args: [],
    );
  }

  /// `Set PIN`
  String get setPin {
    return Intl.message('Set PIN', name: 'setPin', desc: '', args: []);
  }

  /// `Enter a 4-digit PIN`
  String get Enter4DigitsPIN {
    return Intl.message(
      'Enter a 4-digit PIN',
      name: 'Enter4DigitsPIN',
      desc: '',
      args: [],
    );
  }

  /// `Please sign out and reset your PIN`
  String get signOutAndResetPin {
    return Intl.message(
      'Please sign out and reset your PIN',
      name: 'signOutAndResetPin',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message('Done', name: 'Done', desc: '', args: []);
  }

  /// `PIN must be 4 digits`
  String get pinMustBe {
    return Intl.message(
      'PIN must be 4 digits',
      name: 'pinMustBe',
      desc: '',
      args: [],
    );
  }

  /// `Hidden Notes PIN`
  String get hiddenNotesPin {
    return Intl.message(
      'Hidden Notes PIN',
      name: 'hiddenNotesPin',
      desc: '',
      args: [],
    );
  }

  /// `No PIN set`
  String get noPinSet {
    return Intl.message('No PIN set', name: 'noPinSet', desc: '', args: []);
  }

  /// `Incorrect PIN`
  String get incorrectPin {
    return Intl.message(
      'Incorrect PIN',
      name: 'incorrectPin',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
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
