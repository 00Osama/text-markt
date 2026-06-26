import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_markt/core/widgets/internet_connectivity.dart';
import 'package:text_markt/features/auth/presentation/pages/forget_password.dart';
import 'package:text_markt/features/auth/presentation/pages/onboarding_page.dart';
import 'package:text_markt/features/auth/presentation/pages/signin_page.dart';
import 'package:text_markt/features/auth/presentation/pages/signup_page.dart';
import 'package:text_markt/features/auth/presentation/widgets/auth_gate.dart';
import 'package:text_markt/features/events/domain/entities/event.dart';
import 'package:text_markt/features/events/presentation/pages/add_new_event.dart';
import 'package:text_markt/features/events/presentation/widgets/event_preview.dart';
import 'package:text_markt/features/notes/domain/entities/note.dart';
import 'package:text_markt/features/notes/presentation/pages/create_or_update_note_page.dart';

class AppRoutes {
  static const authGate = '/';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgetPassword = '/forget-password';
  static const noteEditor = '/note-editor';
  static const addEvent = '/add-event';
  static const eventPreview = '/event-preview';
}

class NoteEditorRouteExtra {
  const NoteEditorRouteExtra({
    required this.operation,
    this.collection,
    this.index,
    this.note,
    this.currentDay,
    this.dayName,
    this.monthName,
  });

  final String operation;
  final String? collection;
  final int? index;
  final Note? note;
  final DateTime? currentDay;
  final String? dayName;
  final String? monthName;
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.authGate,
  routes: [
    GoRoute(
      path: AppRoutes.authGate,
      builder: (context, state) => const InternetConnectivity(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.forgetPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.noteEditor,
      builder: (context, state) {
        final extra = state.extra;

        if (extra is NoteEditorRouteExtra) {
          return CreateOrUpdateNote(
            operation: extra.operation,
            collection: extra.collection,
            index: extra.index,
            note: extra.note,
            currentDay: extra.currentDay,
            dayName: extra.dayName,
            monthName: extra.monthName,
          );
        }

        return const CreateOrUpdateNote(operation: 'add');
      },
    ),
    GoRoute(
      path: AppRoutes.addEvent,
      builder: (context, state) => const AddNewEvents(),
    ),
    GoRoute(
      path: AppRoutes.eventPreview,
      builder: (context, state) {
        final event = state.extra;

        if (event is Event) {
          return EventPreview(
            title: TextEditingController(text: event.title),
            note: TextEditingController(text: event.note),
            dateTime: event.dateTime,
          );
        }

        return const AuthGate();
      },
    ),
  ],
);
