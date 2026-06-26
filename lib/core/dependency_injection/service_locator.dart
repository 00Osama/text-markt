import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:text_markt/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';
import 'package:text_markt/features/auth/domain/usecases/check_email_verified_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/features/events/data/datasources/events_remote_datasource.dart';
import 'package:text_markt/features/events/data/repositories/events_repository_impl.dart';
import 'package:text_markt/features/events/domain/repositories/events_repository.dart';
import 'package:text_markt/features/events/domain/usecases/add_event_usecase.dart';
import 'package:text_markt/features/events/domain/usecases/delete_event_usecase.dart';
import 'package:text_markt/features/events/domain/usecases/get_events_usecase.dart';
import 'package:text_markt/features/events/presentation/cubits/event_cubit.dart';
import 'package:text_markt/features/notes/data/datasources/notes_remote_datasource.dart';
import 'package:text_markt/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:text_markt/features/notes/domain/repositories/notes_repository.dart';
import 'package:text_markt/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/move_note_usecase.dart';
import 'package:text_markt/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:text_markt/features/notes/presentation/cubits/note_cubit.dart';

class ServiceLocator {
  static late final FirebaseAuth firebaseAuth;
  static late final FirebaseFirestore firebaseFirestore;

  static late final AuthRemoteDataSource authRemoteDataSource;
  static late final AuthRepository authRepository;
  static late final SignInUseCase signInUseCase;
  static late final SignUpUseCase signUpUseCase;
  static late final SignOutUseCase signOutUseCase;
  static late final ResetPasswordUseCase resetPasswordUseCase;
  static late final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  static late final CheckEmailVerifiedUseCase checkEmailVerifiedUseCase;

  static late final NotesRemoteDataSource notesRemoteDataSource;
  static late final NotesRepository notesRepository;
  static late final AddNoteUseCase addNoteUseCase;
  static late final UpdateNoteUseCase updateNoteUseCase;
  static late final DeleteNoteUseCase deleteNoteUseCase;
  static late final MoveNoteUseCase moveNoteUseCase;
  static late final GetNotesUseCase getNotesUseCase;

  static late final EventsRemoteDataSource eventsRemoteDataSource;
  static late final EventsRepository eventsRepository;
  static late final AddEventUseCase addEventUseCase;
  static late final DeleteEventUseCase deleteEventUseCase;
  static late final GetEventsUseCase getEventsUseCase;

  static void setup() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;

    authRemoteDataSource = AuthRemoteDataSource(
      auth: firebaseAuth,
      firestore: firebaseFirestore,
    );
    authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
    );
    signInUseCase = SignInUseCase(repository: authRepository);
    signUpUseCase = SignUpUseCase(repository: authRepository);
    signOutUseCase = SignOutUseCase(repository: authRepository);
    resetPasswordUseCase = ResetPasswordUseCase(repository: authRepository);
    sendEmailVerificationUseCase = SendEmailVerificationUseCase(
      repository: authRepository,
    );
    checkEmailVerifiedUseCase = CheckEmailVerifiedUseCase(
      repository: authRepository,
    );

    notesRemoteDataSource = NotesRemoteDataSource(
      auth: firebaseAuth,
      firestore: firebaseFirestore,
    );
    notesRepository = NotesRepositoryImpl(
      remoteDataSource: notesRemoteDataSource,
    );
    addNoteUseCase = AddNoteUseCase(repository: notesRepository);
    updateNoteUseCase = UpdateNoteUseCase(repository: notesRepository);
    deleteNoteUseCase = DeleteNoteUseCase(repository: notesRepository);
    moveNoteUseCase = MoveNoteUseCase(repository: notesRepository);
    getNotesUseCase = GetNotesUseCase(repository: notesRepository);

    eventsRemoteDataSource = EventsRemoteDataSource(
      auth: firebaseAuth,
      firestore: firebaseFirestore,
    );
    eventsRepository = EventsRepositoryImpl(
      remoteDataSource: eventsRemoteDataSource,
    );
    addEventUseCase = AddEventUseCase(repository: eventsRepository);
    deleteEventUseCase = DeleteEventUseCase(repository: eventsRepository);
    getEventsUseCase = GetEventsUseCase(repository: eventsRepository);
  }

  static AuthCubit createAuthCubit() {
    return AuthCubit(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      signOutUseCase: signOutUseCase,
      resetPasswordUseCase: resetPasswordUseCase,
      sendEmailVerificationUseCase: sendEmailVerificationUseCase,
      checkEmailVerifiedUseCase: checkEmailVerifiedUseCase,
    );
  }

  static NoteCubit createNoteCubit() {
    return NoteCubit(
      addNoteUseCase: addNoteUseCase,
      updateNoteUseCase: updateNoteUseCase,
      deleteNoteUseCase: deleteNoteUseCase,
      moveNoteUseCase: moveNoteUseCase,
      getNotesUseCase: getNotesUseCase,
    );
  }

  static EventCubit createEventCubit() {
    return EventCubit(
      addEventUseCase: addEventUseCase,
      deleteEventUseCase: deleteEventUseCase,
      getEventsUseCase: getEventsUseCase,
    );
  }
}
