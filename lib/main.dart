import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_markt/auth/services/auth_gate.dart';
import 'package:text_markt/bloc/event_cubit.dart';
import 'package:text_markt/bloc/language_cubit.dart';
import 'package:text_markt/bloc/note_cubit.dart';
import 'package:text_markt/bloc/theme_cubit.dart';
import 'package:text_markt/core/theme.dart';
import 'package:text_markt/firebase_options.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/search/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ThemeCubit(sharedPreferences: prefs)..loadThemePreference(),
        ),
        BlocProvider(
          create: (_) =>
              LanguageCubit(sharedPreferences: prefs)..loadLanguagePreference(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => EventCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, langState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: context.watch<LanguageCubit>().locale,
                theme: AppTheme.lightTheme(context),
                darkTheme: AppTheme.darkTheme(context),
                themeMode: context.watch<ThemeCubit>().themeMode,
                home: const InternetConnectivity(),
              );
            },
          );
        },
      ),
    );
  }
}

class InternetConnectivity extends StatelessWidget {
  const InternetConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged.map(
        (list) => list.isNotEmpty ? list.last : ConnectivityResult.none,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
          return const AuthGate();
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/app/noInternet.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 60),
                  Text(
                    S.of(context).noInternetConnection,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
